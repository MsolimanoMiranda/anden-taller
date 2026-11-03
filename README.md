# Taller de fotos

Fichas con imagen en Flutter. Clean Architecture, MVVM vía Bloc, Provider para exponer dependencias y get_it como contenedor. El repositorio empuja la lista por un `Stream`; el bloc se suscribe.

La imagen de esta demo es un puerto (`ruta` + `bytes`). En el teléfono ese puerto lo implementa la cámara o la galería. Aquí entra una imagen en memoria para poder probar sin dispositivo.

## Correr

```bash
cd projects/flutter-taller
flutter test
flutter run
```
