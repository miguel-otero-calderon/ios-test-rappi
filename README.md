# ios-test-rappi
Test de Rappi

La aplicacion esta basada en la arquitectura MVVM.
La aplicacion tiene un buscador de peliculas offline.
Se guarda en cache las imagenes y se optimiza la velocidad de descarga usando un hilo secundario.

-Movie
  -Model 
    -Movie.      :Struct que mapea la informacion de una pelicula ,a nivel de negocio.
                  Contiene la informacion de MovieData y adicionalmente las imagenes y el tipo de pelicula.
  -View
    -MovieView.  :Es la vista del listado de peliculas.
                  Es el ViewController asociado al listado.
                  Contiene solo la logica de presentacion y pintado de la pantalla.
                  Muestra una tableView con 3 filas.
                  En cada fila se encuentra una collectionView con una celda personalizada por cada pelicula.
                  
![image](https://user-images.githubusercontent.com/20627677/137662047-39edb423-49fd-4b13-8314-136dc8673b36.png)
                  
-ViewModel
 -MovieViewModel.:Contiene la logica de negocio, para cargar las peliculas.
                  Descargar las imagenes de todas las peliculas.
                  Almacenar en cache las imagenes.
                  Se implementa el protocolo MovieViewModelProtocol.
                  
![image](https://user-images.githubusercontent.com/20627677/137662900-66ff4f65-d841-49bd-a958-9680a946c57a.png)


-Networking.
 -Movie
   -MovieService : Class que se encarga de la comunicacion con el servidor.
   -MovieData    : Struct que mapea la informacion de una pelicula, tal como lo retorna el servicio.
   -MovieRequest : Struct que mapea la informacion de los parametros del servicio.
   -MovieResponse: Struct que mapea la informacion de la respuesta del servicio.
   -MovieEndPoint: Enum que contiene la informacion para comunicarse con el servicio.
-EndPoint
   -EndPoint.    : Protocolo de comunicacion con cualquier servicio. 

![image](https://user-images.githubusercontent.com/20627677/137662258-e01937f2-4abc-400a-b808-9b413a2abaa8.png)

ios-test-rappiTests
 -ios_test_rappiTests
  -MovieViewTest.: Class que se encarga de realizar el Test al codigo.
  
  ![image](https://user-images.githubusercontent.com/20627677/137663142-dbbefcc9-4e3c-4104-a867-e7ec62f69220.png)

1. Las capas de la aplicación (por ejemplo capa de persistencia, vistas, red, negocio, etc) y
qué clases pertenecen a cual.
2. La responsabilidad de cada clase creada
