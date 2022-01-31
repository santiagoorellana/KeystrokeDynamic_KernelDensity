Contiene el código fuente en Delphi del simulador, que se empleó para evaluar el desempeño del método Kernel en la clasificación de patrones de Keystroke Dynamic.

Contains the Delphi source code for the simulator, which was used to evaluate the performance of the Kernel method in classifying Keystroke Dynamic patterns.

For more details, consult the author:

Santiago A. Orellana Pérez<BR>
Email: tecnochago@gmail.com<BR>
Mobile: +53 54635944<BR>
SetV+, Havana, Cuba, 2017<BR>

<H1>Densidad de Kernel para Autentificación por Dinámica de Tecleo</H1>

Autor: Lic. Santiago Alejandro Orellana-Pérez  

<H3>Resumen</H3>
La Dinámica de Tecleo es una técnica biométrica utilizada para autentificar a los usuarios por su forma de teclear. La presente investigación propone un método para autentificar a los usuarios mediante Dinámica de Tecleo, empleando un método de la estadística no paramétrica, conocido como método de los Kernels y la métrica conocida como Distancia Euclideana. Realizando simulaciones experimentales con el método propuesto, se logró obtener un FAR de 2,26% y un FRR de 1,8%. 

<H3>Summary</H3>
Keystroke Dynamics is a biometric technique used to authenticate users by their typing. This research proposes a method to authenticate users through Keystroke Dynamics, using a method of non-parametric statistics, known as the Kernels method, and the metric known as Euclidean Distance. Carrying out experimental simulations with the proposed method, it was possible to obtain an FAR of 2.26% and an FRR of 1.8%.

<H3>1 - Introducción</H3>
La mayor parte de los sistemas computarizados modernos, se protegen de accesos no permitidos mediante una contraseña (password). Los usuarios suelen anotarlas o utilizar nombres de familiares, fechas importantes o cualquier dato para recordarlas. Estas vulnerabilidades hacen posibles los ataques a datos importantes, como cuentas bancarias, o el acceso no permitido a informaciones confidenciales. La observación de que los patrones de tecleo de un mismo usuario tienden a repetirse y se diferencian de los de otros usuarios, motivó la idea de implementar sistemas que autentifiquen al usuario por su forma de teclear (Gaines y otros, 1980). Con el paso del tiempo, esta técnica biométrica, aún en estudio, ha sido conocida como Keystroke Dynamic, en español, Dinámica de Tecleo (DT). Una de las principales ventajas de la DT es que no requiere de un dispositivo adicional, por lo que los costos son mínimos. 

El tecleo de un usuario puede descomponerse en dos eventos básicos llamados KeyDown, cuando la tecla es presionada, y KeyUp cuando la tecla es soltada y regresa a su posición normal. Durante el tecleo de una palabra o frase, el Intervalo de tiempo definido por los eventos KeyDown de una tecla y KeyDown de la tecla que le sigue inmediatamente, se denomina Di-graph.

![C1](https://user-images.githubusercontent.com/59070402/151732521-b5efa04f-9037-4173-a974-4e1d3114dd61.png)

Figura 1. Representación gráfica de un intervalo Di-graph al teclear “AB”. Nótese que el intervalo comienza por el evento KeyDown de la tecla A y termina en el evento KeyDown de la tecla B. Los eventos KeyDown de ambas teclas están representados de color rojo.

Los intervalos Di-graph pueden ser utilizados para conformar un vector de tiempos que caracteriza la forma en que el usuario teclea. Cuando el usuario teclea la misma secuencia de teclas, tiende a generar el mismo vector de tiempo asociado a dicha secuencia, diferenciándose solamente en pequeña magnitud por ruidos aleatorios, a lo que gran parte de los investigadores le suponen una distribución normal.
Al realizar algunas observaciones de los vectores de tiempo de las muestras de las bases de datos públicas en Internet (Loy, 2005) se puede constatar que no todos los vectores de tiempo tienen una variación que responde a una distribución normal. En algunos casos los valores (rasgos) del vector de tiempo de los usuarios, presentan variaciones que responden a distribuciones desconocidas.

 ![dbxample1](https://user-images.githubusercontent.com/59070402/151734215-e73cf507-b0c2-45bd-94b4-691c8e3d2076.png)
 
Figura 2. Representación gráfica de 10 vectores de tiempo de un usuario cuyas variaciones se ajustan a una distribución normal. Los siete intervalos son representados en el eje X, mientras que el eje Y representa la duración en milisegundos. Datos tomados de la base “Keystroke100 Dataset” disponible en Internet (Loy, 2005).

![dbxample2](https://user-images.githubusercontent.com/59070402/151734222-f53bf5de-2eb3-4b16-b511-fc3c473cbdca.png)

Fugura 3. Representación gráfica de 10 vectores de tiempo de un usuario con variaciones que no se ajustan a una distribución normal. Los siete intervalos son representados en el eje X, mientras que el eje Y representa la duración en milisegundos. Datos tomados de la base “Keystroke100 Dataset” disponible en Internet (Loy, 2005).

Cuando se trabaja con distribuciones de frecuencia que no tienen el patrón de la curva normal, entonces una de las alternativas es utilizar Estadística No Paramétrica para estimar la distribución real de los datos, pudiéndose calcular la densidad de probabilidad a partir de los mismos datos, en vez de suponer de antemano que tendrán una distribución normal. En referencia a esta técnica se dice (Camacho, 2002) en la literatura: dejar que los datos “hablen por sí solos”. 
El presente trabajo propone un método de autentificación de usuarios por Dinámica de Tecleo de “Texto Estático”, empleando un método de estadística no paramétrica conocido como método de los Kernel (Núcleos). 

<H3>2 - Análisis de los antecedentes</H3>
En una publicación de un estudio comparativo sobre los diversos métodos de autentificación por Dinámica de Tecleo (Banerjee y Woodard, 2012), se pudo encontrar una referencia a un trabajo investigativo (Janakiraman y Sim, 2007) en el cual se emplean histogramas para estimar la Función de Densidad de Probabilidad (FDP) de los intervalos que conforman el vector de tiempos. Según los investigadores Janakiraman y Sim, las distribuciones de los datos observadas eran realmente Gaussianas, por lo que decidieron representar la FDP como un histograma con parámetros similares a los de una FDP Gaussiana multidimensional. De esta manera, la publicación se aleja del interés de la presente investigación, al asumir que las distribuciones de los intervalos siempre serán Gaussianas.

Luego de revisar un estudio comparativo (Alsultan y Warwick, 2013) de varios trabajos dedicados a la dinámica de tecleo en la modalidad “Texto Libre”, se pudo constatar que de las 24 publicaciones analizadas, solo una (Davoudi y Kabir, 2008) emplea estadística no paramétrica para estimar la función de densidad de los intervalos de los vectores de tiempos.

Davoudi y Kabir proponen un método de autentificación del tipo “Texto Libre” utilizando histogramas para aproximarse a la FDP de cada intervalo. Luego calculan la distancia entre el intervalo del usuario desconocido y la FDP del intervalo del usuario conocido. 

Para validar el algoritmo, utilizaron 21 sujetos de los cuales se tomaron varias muestras cuya longitud varía de 700 a 900 caracteres y los datos fueron capturados con una precisión de hasta 1 milisegundo. De cada sujeto se tomaron 15 muestras para entrenamiento obteniéndose al final un FAR igual a 0.14% y un FRR de 1.58%.
A pesar de que este método de autentificación muestra buenos resultados, cabe destacar que se cuenta con grandes cantidades de muestras por usuario, pero se desconoce la eficiencia del método al trabajar con muestras pequeñas como las que se emplean en las contraseñas (de 8 a 20 caracteres). 

Además, una desventaja de los histogramas es que son funciones discontinuas, lo cual los convierte en estimadores insatisfactorios. Al ser funciones constantes a trozos, su primera derivada es cero en casi todo punto, lo que los hace inadecuados para estimar la derivada de la función de densidad. Tampoco son buenos para estimar las modas y aunque pueden proporcionar “intervalos modales", esto puede resultar inadecuado en los casos en que se necesita mayor precisión (Cuevas, 2002).
Para superar todas estas dificultades se diseñaron los estimadores de tipo núcleo (kernel) cuya idea original se remonta a los años 50 y primeros 60, siendo en la actualidad los estimadores más utilizados y mejor estudiados en la teoría no paramétrica (Cuevas, 2002).

<H3>3 – Método que se propone</H3>
<H3>3.1 - Modelo de datos</H3>
Si las componentes de un vector de tiempo de una secuencia de teclas dada, se representan como x1, x2, …, xn, entonces varios vectores de tiempo de una misma secuencia de teclas se pueden tratar como una matriz de la forma:

![MatrizA](https://user-images.githubusercontent.com/59070402/151732792-0c9f50d7-8abe-49fa-8670-36cdd8617b89.png)

Figura 4. Estructura de una Matriz Representativa de Usuario de <b>n</b> columnas y <b>m</b> filas.

donde <b>n</b> es la cantidad de componentes de los vectores de tiempos de la secuencia de teclas y <b>m</b> es la cantidad de vectores de tiempo. De esta manera <b>xij</b> representa una componente de uno de los vectores de tiempo, siendo <b>i</b> el índice del vector y <b>j</b> el índice del intervalo. De modo que <b>x11, x12, …, x1n</b> es el primer vector de tiempo, <b>x21, x22, …, x2n</b> representa el segundo vector y así sucesivamente, fila por fila.
Si todos los vectores de tiempo que se almacenan en <b>X</b>, pertenecen a un mismo usuario, entonces <b>X</b> es una Matriz Representativa del usuario a partir de la cual se puede realizar análisis estadísticos. Cabe destacar que el término Matriz Representativa se emplea solamente con el significado que se le da en el presente documento.

<H3>3.2 - Comparación de semejanza</H3>
Los vectores de tiempo de una matriz tipo <b>X</b> pueden ser comparados con otro vector de tiempo <b>V</b> del mismo orden <b>n</b> (que tengan la misma cantidad de componentes). El resultado de la comparación es una puntuación que cuantifica el grado de similitud del vector <b>V</b> con los vectores que forman la matriz <b>X</b>. En el presente documento se le llamará Comparación de Semejanza (CS) a las comparaciones como la descrita anteriormente. 

![Comparación de semejanza](https://user-images.githubusercontent.com/59070402/151733084-97dac6dd-65cc-4a49-beb8-b9126993465f.png)

Figura 5. Ejemplo gráfico del proceso de CS, donde se resaltan las columnas de la matriz correspondientes a un mismo intervalo o rasgo.

Si de un usuario se tiene una Matriz Representativa y se tiene además un vector de tiempo de un usuario desconocido, entonces mediante una CS se puede inferir si el usuario desconocido es el mismo representado por la matriz. Esto bajo la suposición de que existen diferencias entre los vectores de tiempo de diferentes usuarios. La comparación de vectores de tiempo con Matrices Representativas constituye la base sobre la cual se construye el método de autentificación estático que se propone. La descripción de la comparación se da a continuación paso por paso.

<H3>3.3 - Cálculo de la Densidad de Probabilidad</H3>
Empleando Estadística no Paramétrica es posible estimar la Densidad de Probabilidad de las componentes de los vectores de tiempo contenidos en una Matriz Representativa, pudiéndose obtener así una Función de Densidad para cada uno de los intervalos de una secuencia de teclas dada. Si los valores que toma el intervalo <b>j</b> de una secuencia de teclas en cada uno de los <b>m</b> vectores de la matriz son <b>x1j, x2j, …, xmj</b>, entonces la Densidad de Probabilidad se puede estimar por el método de los Kernels mediante la siguiente función (Miñarro, 1998).

![Densidad](https://user-images.githubusercontent.com/59070402/151733211-85390b44-79ba-4147-8b5e-4693b8debf7b.png)

En donde <b>m</b> es la cantidad de vectores de tiempo o filas que conforman la Matriz Representativa y <b>j</b> es la columna de componentes a partir de los cuales se calcula la densidad de probabilidad. La densidad se calcula para el valor <b>z</b> siendo <b>xij</b> los valores de la Matriz Representativa <b>X</b> y <b>h</b> un parámetro que determina el grado de suavizado de la función.  La función de densidad simétrica <b>K</b> se comporta como estimador básico de la probabilidad, a partir del cual se calcula la Densidad de Probabilidad que se quiere estimar. La función núcleo <b>K</b> puede ser de varios tipos (Miñarro, 1998; Camacho, 2002; Zucchini, 2003), con diferentes grados de eficiencia:

![Nucleos](https://user-images.githubusercontent.com/59070402/151733302-bd44bba7-7cfb-471d-ba09-c09cfa63843d.png)

Figura 6. Algunos tipos de núcleos utilizados para la estimación de densidad de probabilidad.

El rango de valores que toma  <b>z</b> va de 0 hasta el infinito, pero en la práctica se determina la densidad en un intervalo que va de 0 a 1000 milisegundos, partiendo de que las componentes de los vectores no son negativas y que por lo general las componentes más útiles para la autentificación se encuentran por debajo de 1000 milisegundos. 

![DistribuciónDeFrecuencia](https://user-images.githubusercontent.com/59070402/151733344-a0e9f4b1-7bc4-4228-a41c-940f5f5a03f9.png)

Figura 7. Gráfico adaptado de (Bello, 2010) donde se observa la distribución de frecuencia de los intervalos del tecleo. Obsérvese que la mayor parte de la concentración está por debajo de 1000 milisegundos, concentradas aún más por debajo de los 500 milisegundos.

No obstante, el valor máximo del rango puede extenderse a más de 1000 milisegundos teniendo siempre en cuenta la demora del cálculo numérico de la Densidad de Probabilidad.

<H3>3.4- Cálculo de la puntuación</H3>
La puntuación consiste en asignar a un vector de tiempos <b>V</b> un valor que represente el grado de semejanza entre <b>V</b> y los vectores de la Matriz Representativa <b>X</b> de un usuario. En la presente investigación se propone calcular la puntuación de <b>V</b> a partir de la estimación de la Densidad de Probabilidad en cada una de las <b>n</b> componentes de los <b>m</b> vectores contenidos en <b>X</b>. Así, la puntuación para la componente <b>j</b> del vector de tiempo <b>V</b> (intervalo j del vector de tiempo V) de una secuencia de teclas específica se calcula por:

![Puntuacion](https://user-images.githubusercontent.com/59070402/151733442-fc5de21f-7643-47b9-b8f0-c598da4cd9ee.png)

donde <b>pj</b> representa la puntuación para la componente o intervalo <b>j</b> del vector <b>V</b>. La puntuación de la componente <b>j</b> de <b>V</b> es proporcional a la Densidad de Probabilidad de la componente <b>j</b> en los vectores que conforman <b>X</b>. Luego se divide entre el máximo de la función para normalizar los valores de <b>pj</b> en el rango de 0 a 1, evitando así que el cálculo numérico de la puntuación final resulte en un desbordamiento de los cálculos en la computadora (overflow).  
La puntuación final <b>P</b> se calcula a partir de los valores <b>p1, p2, …, pn</b>, de las componentes, de la siguiente manera:

![PuntuacionFinal](https://user-images.githubusercontent.com/59070402/151733543-9cd10d34-ba75-407a-baaa-4e32a09b4ad2.png)

Esta expresión se ha construido a partir de la Distancia Euclidiana, para medir la distancia entre el vector conformado por los valores <b>p1, p2, …, pn</b>, y el vector del mismo orden cuyos componentes son todos iguales a 1. Debido a que los valores <b>pj</b> están normalizados y solo pueden ser valores de 0 a 1, entonces al ser elevados al cuadrado, nunca son mayores que 1, por lo que el numerador solo puede llegar a un valor máximo: Raíz cuadrada de <b>n</b>. Luego al dividir el numerador por este valor máximo, se logra normalizar la puntuación final en un rango de 0 a 1. 

<H3>3.5 - Umbral de aceptación</H3>
Si la puntuación obtenida de la comparación de un vector V de un usuario desconocido, con una Matriz Representativa X de un usuario conocido es superior a un valor preestablecido, entonces se considera que el vector V pertenece al usuario representado por la matriz X. El valor preestablecido se denomina Umbral de Aceptación y puede ser seleccionado en dependencia de la rigurosidad que se necesite en el proceso de clasificación.

<H3>4 – Pruebas experimentales</H3>
<H3>4.1 - Programa para las simulaciones </H3>
Con el objetivo de comprobar la eficacia del método de autentificación propuesto, se implementó una aplicación de simulación que prueba el método con los vectores de tiempo de 100 usuarios. Los vectores de tiempo fueron obtenidos de la bases de datos llamada “Keystroke100 Dataset” (Loy, 2005), de la cual el autor explica que antes de introducir los datos, los usuarios se familiarizaron con el texto que debían teclear. Las características de la base de datos son las siguientes:

* Cantidad de usuarios = 100						
* Texto que teclearon = “try4-mbs”						
* Rasgo que se mide = Di-graph
* Precisión de la medición = milisegundos
* Muestras tomadas por cada usuario = 10 (Cantidad de repeticiones del texto)	

El algoritmo de simulación crea un perfil patrón con cada uno de los usuarios de la base de datos y luego intenta comparar el perfil patrón de cada uno de los usuarios contra las muestras de todos los usuarios de la base de datos, incluyendo al las del mismo usuario que se está comprobando. Cada usuario se compara con 1000 muestras, por lo que al final de la simulación, se tienen 100000 comparaciones realizadas. Durante la simulación, se cuentan la cantidad de errores cometidos en la comparación, y al terminar se muestra el FAR (Falsos positivos) y FRR (Falsos negativos) del proceso de simulación. También se muestra la precisión del método y la tasa de error en porciento. 

Dada la cantidad de usuarios de la base de datos y la cantidad de muestras por cada uno, se conoce de antemano que el total de muestras falsas que se comparan con el patrón de cada usuario es igual a 10 * 99 y si esto lo multiplicamos por la cantidad de usuarios que es 100, entonces se tiene que el total de muestras falsas es 99000. El 99 se debe a que no se cuentan las muestras del usuario que se comprueba. La cantidad de muestras verdaderas de cada usuario es igual a 10, ya que son las del mismo usuario. Con esto, se conoce entonces que el máximo de muestras verdaderas que se prueban es igual a 1000. Entonces conocidos los máximos de muestras genuinas y falsas se pueden calcular los FAR y RRR. 

El programa de simulación es muy sencillo y tiene el aspecto que se muestra en la figura:

![prog](https://user-images.githubusercontent.com/59070402/151733687-3183b9a4-7959-47bb-b101-2ec6612e940e.png)

Figura 8. Especto del programa de simulación.

<H3>4.2 - Resultado de las simulaciones</H3>
En las simulaciones se utilizó un kernel del tipo “Triweigth” y un factor de suavizado de 0.001 para la función kernel. Como resultado se obtuvieron las siguientes mediciones:

![result](https://user-images.githubusercontent.com/59070402/151733840-41dd6fc8-9f4b-4086-b792-7524d7db0d2e.png)

Tabla 1. Resultados de las simulaciones realizadas con el método propuesto. Se resalta en color naranja la simulación que más se aproximó al punto de igualdad entre el FAR y FRR.

En color azul se muestran los parámetros de entrada de la simulación, mientras que en amarillo se muestran los resultados de cada una de las simulaciones. Cada fila de la tabla corresponde a una simulación con un umbral diferente, y se puede ver que el punto en que el FAR y el FRR se igualan, se encuentra cuando el umbral está entre 0.29 y 0.30. Este punto de igualdad del FAR y el FRR se puede ver en la tabla que se presentará a continuación, como el punto de cruce de las dos líneas:

![FAR-FRR](https://user-images.githubusercontent.com/59070402/151734031-a4db5f5e-c2a4-4875-a063-47b401295c8f.png)

Figura 9. La gráfica anterior muestra el FAR y el FRR para cada uno de los umbrales para los cuales se realizó la simulación. El valor de los umbrales corresponde al eje X empezando en 0.03 y terminando en 0.60, siendo el punto de cruce un valor entre 0.29 y 0.30. Como se puede ver, la curva de caída del FAR y el FRR es bastante brusca, por lo que queda un espacio intermedio en el cual ambas medidas son bajas, lo cual facilita mucho la selección del umbral correcto. 

<H3>5 – Discusión</H3>
Este algoritmo es un buen candidato para su utilización en la clasificación, ya que da buenos resultados empleando una base matemática bastante documentada y estudiada: la estimación de Funciones de Densidad por el Método de los Kernel y la Distancia Euclidiana. 

Se puede ver en la tabla de simulaciones que mediante la selección adecuada del umbral, se puede determinar la rudeza del método al autentificar a los usuarios. Con un umbral muy bajo, aumenta el FAR, lo cual disminuye la seguridad del sistema que se protege, pero evita que los usuarios genuinos sean rechazados erróneamente. Al contrario, con un umbral bastante alto se aumenta la seguridad del sistema, pero se puede dar el caso de que de vez en vez algún usuario genuino sea rechazado por el sistema. 

Hay que señalar que la base de datos “Keystroke100 Dataset” solo contiene 10 muestras por usuario, afectando la calidad de las simulaciones, por lo que se propone realizar una prueba con más muestras por usuario, empleando otra base de datos más extensa. Así las muestras se pueden dividir en dos conjuntos, uno de “entrenamiento” y otro de “prueba”, para comprobar la posibilidad del método propuesto de reconocer las muestras para las cuales no ha sido entrenado.  
Debido a que cada simulación demora mucho tiempo en terminar y los umbrales se debían ajustar manualmente al inicio de cada simulación, solo se pudieron probar valores discretos en el rango de 0.03 a 0.60, y siempre empleando un factor de suavizado de 0.001. Tampoco se pudo comprobar la efectividad del método con otros tipos de kernel como el Gaussiano. 

El próximo paso de avance en las simulaciones debe consistir en la implementación de una aplicación que pruebe los umbrales en el rango de 0 a 1 en combinación con diferentes factores de suavizado y empleando diferentes núcleos. Como esas simulaciones serán más costosas para la computadora, entonces los resultados deberán irse guardando constantemente en el disco duro, porque el proceso puede durar varios días y puede que sea necesario detener momentáneamente la simulación. Además, si es posible, debe realizarse empleando técnicas de procesamiento paralelo para agilizar la ejecución realizando varias simulaciones simultáneamente. Para esto se necesitará preferiblemente una computadora con un CPU de múltiples núcleos.

<H3>6 - Conclusiones</H3>
El método de autentificación por Dinámica de tecleo que se propone ha dado buenos resultados en las pruebas experimentales de simulación que se realizaron, pero aún no se ha realizado una prueba con bases de datos más extensas que contengan una gran cantidad de muestras por usuarios, y tampoco se ha comprobado la efectividad del método al reconocer patrones en muestras para las cuales no ha sido entrenado. En próximos trabajos se deberán abarcar todas estas problemáticas, para caracterizar mejor el método propuesto.

<H3>7 - Bibliografía</H3>
C. C. Loy, (2005), Keystroke100 Dataset, Obtenido de: http://www.eecs.qmul.ac.uk/~ccloy/files/datasets/keystrokes.zip,  Accedido en 2013.

Camacho Alonso, A., (2002) Estimación no-paramétrica, Universidad de Murcia, Obtenido de: www.um.es/econometria/tecpre

Miñarro A. (1998), Estimación no paramétrica de la función de densidad, Barcelona. Zucchini W. (2003), Applied Smoothing Techniques: Kernel Density Estimation.

Cuevas A. (2002), El Análisis Estadístico de Grandes Masas de Datos: Algunas Tendencias Recientes, Departamento de Matemáticas, Universidad Autónoma de Madrid. 

Bello L., Bertacchini M., Benitez C., Pizzoni J. C. y Cipriano M. (2010) Collection and Publication of a Fixed Tex Keystroke Dynamics Dataset, XVI Congreso Argentino de Ciencias de la Computación (CACIC 2010), pp 822-831.

Davoudi H. y Kabir E. (2008), A New Distance Measure for Free Text Keystroke Authentication.

Alsultan A. y Warwick K. (2013) , Keystroke Dynamics Authentication: A Survey of Free-text Methods, International Journal of Computer Science Issues, IJCSI 2013, Vol. 10, No. 1, pp 1-10, Obtenido de: www.IJCSI.org

Hu, J., Gingrich, D., Sentosa, A. (2008), A k-nearest neighbor approach for user au-thentication through biometric keystroke dynamics. International Conference on Communications, IEEE. 

Banerjee S. P. Y  Woodard D. L. (2012), Biometric Authentication and Identification using Keystroke Dynamics: A Survey, Journal of Pattern Recognition Research, Pag. 116-139.

Janakiraman R. y Sim T. (2007), Keystroke Dynamics in a General Setting. Advances in Biometrics, Lecture Notes in Computer Science, Vol. 4642, pp 584–593.

