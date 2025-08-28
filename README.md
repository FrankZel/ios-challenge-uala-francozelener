# 📱 Mobile Challenge - Ualá

This is a mobile development challenge that may be resolved in **Kotlin (Android)** or **Swift (iOS)**.

---

## 🎯 Goal

The goal of this assignment is to evaluate:

- 🧠 Problem-solving skills  
- 🎨 UX judgment  
- 🧼 Code quality  

You should approach this as if building for production.

---

## ✅ Requirements

### 📥 Cities Dataset

You’ll be provided a list of ~200,000 cities in JSON format. Each entry looks like:

```json
{
  "country": "UA",
  "name": "Hurzuf",
  "_id": 707860,
  "coord": {
    "lon": 34.283333,
    "lat": 44.549999
  }
}
```

You must:

### 🔍 Implement Search

- Download the cities list from [this gist](https://gist.githubusercontent.com/hernan-uala/dce8843a8edbe0b0018b32e137bc2b3a/raw/0996accf70cb0ca0e16f9a99e0ee185fafca7af1/cities.json)
- Filter by prefix string:
  - Case-insensitive
  - Must match the beginning of the city name only (see clarification below)
  - **Optimized for fast search** (UI responsiveness > load time)
- Filtered results must be shown:
  - In a **scrollable list**
  - **Alphabetically sorted** → "Denver, US" before "Sydney, AU"
  - List updates on every keystroke
  - Toggle to show **only favourites**

---

## 🖼️ UI Specifications

### List Cell Requirements

Each city cell must display:

- ✅ City + Country Code (e.g., `Buenos Aires, AR`)
- 📍 Coordinates (lat/lon)
- ⭐ Toggle as Favourite
- 🗺️ Tap to center map on city location
- ℹ️ "Show details" button → opens city info screen

---

### 🗺️ City Info Screen

- Show any additional data not displayed in list
- May include extra data from other sources
- Organize layout for **good UX**

---

### 🔁 Responsive Layouts

- **Portrait** → separate screens for list + map  
- **Landscape** → use single screen to combine them  

---

## 💾 Persistence

- ⭐ Favourite cities must persist across app launches using local storage

---

## 🧪 Testing

- ✅ Unit tests for search algorithm:
  - Include valid and invalid inputs
- ✅ Unit/UI tests for key screens

---

## 🧠 Evaluation Criteria

- `README.md` must explain:
  - Search optimization approach
  - Design decisions and assumptions

- ✅ Search performance and UX quality
- ✅ Clean, maintainable, testable code
- ✅ Comments for non-trivial logic

---

## 🚫 Restrictions

- **No 3rd party libraries allowed**
- Use latest **stable** SDKs/tools only
- Pre-release versions are **forbidden**

### For Android:

- Jetpack Compose
- Compatible with latest Android API

### For iOS:

- SwiftUI
- Compatible with latest iOS & Swift versions

---

## ✳️ Prefix Matching Clarification

The filter must match from the **start** of the city name:

### Example dataset:

```
Alabama, US  
Albuquerque, US  
Anaheim, US  
Arizona, US  
Sydney, AU
```

| Prefix | Results |
|--------|---------|
| `"A"`  | Alabama, Albuquerque, Anaheim, Arizona |
| `"Al"` | Alabama, Albuquerque |
| `"Alb"`| Albuquerque |
| `"s"`  | Sydney (only) |

---

> Good luck 🚀
> (Transcripto del pdf provisto con chatgpt)


# Solución

## Búsqueda 
Use el searchable de swift para hacer la busqueda, y el algoritmo esta definido de mostrar las favoritas si el boton de favorito esta activo, o si no usar toda las ciudades. Lleva todo a minusculas y uso el hasprefix basado en el texto de busqueda.

## Renderizado
Al principio habia decidido usar NavigationSplitView para la pantalla dividida, pero ante la necesidad de dividir la pantalla independientemente del dispositivo, y el uso de ScrollaView + LazyVStack para una mejor perfomance, decidi usar el Geometry reader para saber si estoy en landscape o en portrait y dependiendo de la orientacion, uso una navegacion estandar o una pantalla dividida.

## Data
Usado el gist de datos que proveia el ejercicio, tengo los datos de las ciudades. Y como extra, consumí datos de la API de OpenWeatherMap (https://openweathermap.org/) para saber los datos climaticos dependiendo de la ciudad, y además se consumió GeoDB Cities dentro de RapidAPI (https://rapidapi.com/wirefreethought/api/geodb-cities)


