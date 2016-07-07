#Práctica de Fundamentos de iOS

##1.- Modelo

###1.- Gestión de las imágenes y los pdfs

El fichero json la primera vez lo descargo a la carpeta Documents de la SandBox. Este documento no quiero perderle por eso lo guardo aquí.

Las imágenes y los pdf los he guardado en la carpeta de Caché de la SandBox. Son datos que agilizan la app, pero si el sistema necesita eliminarlos lo hará, y no me importa perderlos porque los descargaré otra vez. 

Dentro del modelo guardo sus direcciones NSURL, cuando las necesito busco primero en local a ver si están, si no están las descargo. Así la próxima vez que la necesite estará el local y agilizo la app.

##2.- Tabla de libros

###1.- Gestión de favoritos

Los favoritos los guardo en un Set<String> dentro del modelo utilizando el nombre del libro. El Set me permite que no haya ninguno repetido. Para guardar este Set<String> lo convierto a un NSArray y utilizo un método que guarda la información en disco en forma de xml.
Cuando arranca la app uso el método del lectura del NSArray y lo meto en el Set de favoritos. Así ya parto de la info guardada.

###2.- Cambio de valor en propiedad "isFavorite"
El añadir un favorito está en el controlador de vista de "Book". Cuando se hace click en favorito:

- Se actualiza el modelo de Book modificando el "isFavorite"
- Se le comunica al "LibrayViewController" a través de un delegado que el modelo de uno de sus libros ha cambiado, y tiene que "re-pintar" la tabla.

Otra opción hubiese sido hacerlo con notificaciones, pero el resultado es el mismo y opto por la opción más sencilla.

###3.- Actualización de la tabla por "reloadData"

Yo creo que al estar los recursos en local y cargados en los modelos "Book", recargar la tabla no es una aberración. Si fuesen muchos.
La forma alternativa sería ir cargando los modelos según se necesiten. Si fuesen muchos registros que hay que descargar en remoto.

##3 .- Controlador de PDF

Para actualizar el PDF, cuando el usuario cambia de celda seleccionada el controlador de la librería manda una notificación. El controlador de vista del libro y del pdf se subscriben a esta notificación y así se enteran de que tienen que actualizarse

# -- EXTRAS --

Estos son algunos de los extras que he añadido:

* La carga de los PDF se hace en backgound por GCD así veo el activity en el visor mientras carga.
* 

