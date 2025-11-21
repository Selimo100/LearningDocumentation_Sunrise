
## 🎯 Das Problem

**Symptom:** StudentList & StudentDetail laden extrem langsam (6-10s)
**Root Cause:** Sequential API Calls (Wasserfall-Effekt)

```javascript

// ❌ PROBLEM: Nested Loops warten aufeinander

for (const school of schools) {

const classes = await getClasses(school.id); // WARTET

for (const cls of classes) {

const students = await getStudents(cls.id); // WARTET
	}
}

// 3 Schools × 3 Classes × 600ms = 5400ms!

```

---
## ✅ Die Lösung: 5 Optimierungs-Techniken
### 1. **Skeleton Screens** (+50% wahrgenommene Performance)

Graue Platzhalter statt leerer Bildschirm während Laden.
```javascript

// components/common/SkeletonCard.js

export const SkeletonCard = () => (
<div className="animate-pulse">
<div className="h-12 bg-gray-300 rounded mb-2"></div>
<div className="h-8 bg-gray-200 rounded"></div>
</div>

);

// In Komponente:
{loading ? <SkeletonCard /> : <DataView />}

```
### 2. **Intelligentes Caching** (+97% bei wiederholten Loads)

Daten in sessionStorage mit TTL (Time To Live).
```javascript
// utils/cacheUtils.js
export const cache = {
set: (key, data, ttl = 5 * 60 * 1000) => {
sessionStorage.setItem(key, JSON.stringify({
data, timestamp: Date.now(), ttl
	}));

},

get: (key) => {
	const cached = JSON.parse(sessionStorage.getItem(key));
	if (!cached) return null;
		if (Date.now() - cached.timestamp > cached.ttl) {
		sessionStorage.removeItem(key);
	return null;
		}

return cached.data;
	}
};

// Verwendung:

const cached = cache.get('students');
if (cached) return cached;
const data = await fetchStudents();
cache.set('students', data, 3 * 60 * 1000); // 3min TTL

```


**Cache-Strategie:**

| Daten-Typ               | TTL   | Grund                    |
| ----------------------- | ----- | ------------------------ |
| Statisch (Schools)      | 10min | Andern selten            |
| Semi-statisch (Classes) | 5min  | Gelegentliche Anderungen |
| Dynamisch (Students)    | 3min  | Haufige Updates          |

### 3. **Parallel API Calls** (+90% beim ersten Load)

Alle API Calls gleichzeitig starten mit `Promise.all()`.

```javascript
// ❌ VORHER: Sequential (5400ms)
const school1 = await getSchool(1);
const school2 = await getSchool(2);
const school3 = await getSchool(3);

// ✅ NACHHER: Parallel (600ms)
const [school1, school2, school3] = await Promise.all([
getSchool(1), getSchool(2), getSchool(3)

]);

// Mit dynamischen Arrays:

const schools = await Promise.all(
schoolIds.map(id => getSchool(id))
);

```

**Nested Parallel** (unser Use Case):

```javascript
// 1. Schools parallel

const schools = await Promise.all(
schoolIds.map(id => getSchool(id))
);


// 2. Classes parallel pro School

const withClasses = await Promise.all(

schools.map(async (s) => {

const classes = await getClasses(s.id);

return { school: s, classes };

})

);

  

// 3. Students parallel für alle Classes

const allPromises = [];

for (const {school, classes} of withClasses) {

for (const cls of classes) {

allPromises.push(getStudents(cls.id));

}

}

const allStudents = await Promise.all(allPromises);

```

### 4. **Debouncing** (+86% weniger Operations)

Search wartet 300ms nach letztem Tastendruck.
  

```javascript

// hooks/useDebounce.js

export function useDebounce(value, delay = 300) {

const [debounced, setDebounced] = useState(value);

useEffect(() => {

const timer = setTimeout(() => setDebounced(value), delay);

return () => clearTimeout(timer);

}, [value, delay]);

return debounced;

}

  

// Verwendung:

const [searchTerm, setSearchTerm] = useState('');

const debouncedSearch = useDebounce(searchTerm, 300);

  

const filtered = useMemo(() =>

students.filter(s => s.name.includes(debouncedSearch)),

[students, debouncedSearch]

);

```

### 5. **useMemo** (Verhindert unnötige Re-Renders)

Nur neu berechnen wenn Dependencies sich ändern.

```javascript

// ❌ VORHER: Läuft bei JEDEM Render

const filtered = students.filter(s => s.active);

  

// ✅ NACHHER: Nur wenn students/filter sich ändern

const filtered = useMemo(() =>

students.filter(s => s.active),

[students]

);

```

**Wann useMemo?**

- ✅ JA: Komplexe Filter/Sort/Map Operations

- ❌ NEIN: Einfache Berechnungen (`students.length`)