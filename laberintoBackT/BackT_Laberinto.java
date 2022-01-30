import java.util.Objects;
import javax.swing.*;
import java.awt.*;


/**
 * Autor : Alejandro García Peláez
 * Descripcion: pequeño programa que resuelve cualquier laberinto que se introduzca
 * Fecha: 30-01-2022
 */


public class BackT_Laberinto {

    //Fijamos el tamanio del tablero
    final static int SIZE = 5;
    private int[][] SOLVED;

    /**
     *
     * @param matriz : matriz a mostrar.
     *  El metodo es un simple recorrido mostrado por consola, usado auxiliarmente
     *  en el desarrollo del codigo.
     */

    public static void show(int[][] matriz){
        for(int i = 0;i < matriz.length;i++){
            for(int j = 0;j< matriz.length;j++){
                System.out.print(matriz[i][j] + " ");
            }
            System.out.println();
        }
    }

    /**
     * Clase auxiliar creada para controlar el estado del backTracking asi como
     * facilitar la siguiente posicion.
     */

    private static class pos{

        private int fila,columna;
        public pos(int f,int c){
            fila = f;
            columna = c;
        }

        /**
         *
         * @param e: estado actual de la posicion; nos indica cual es la siguiente posicion a probar
         * @return siguiente posicion
         */

        public pos next(int e){
            if(e < 4){
                switch(e){
                    case(0): return new pos(fila-1,columna);
                    case(1): return new pos(fila,columna+1);
                    case(2): return new pos(fila+1,columna);
                    default: return new pos(fila,columna-1);
                }
            }else throw new RuntimeException("ERROR");
        }

        /**
         *Definimos de nuevo tanto el metodo equals como el hashCode. De esta manera podemos
         * comparar inequivocamente dos objetos de la clase creada
         */

        @Override
        public boolean equals(Object o) {
            if(this.getClass() == o.getClass()){
                pos pAux = (pos) o;
                if(pAux.fila == this.fila && pAux.columna == this.columna) return true;
                else return false;
            }else return false;
        }

        @Override
        public int hashCode(){
            return Integer.hashCode(fila) + Integer.hashCode(columna);
        }
    }

    /**
     * @param matriz: rellenamos toda la matriz de ceros
     */

    public static void fill(int[][] matriz){
        for(int i = 0;i < matriz.length;i++){
            for(int j = 0;j< matriz.length;j++){
                matriz[i][j] = 0;
            }
            System.out.println();
        }
    }

    /**
     *
     * @param p: posicion que queremos comprobar
     * @param mat: matriz donde comprobamos si p es igual a cero; de ser así el backTracking puede continuar
     *           por ahi.
     * @return true si es igual a cero; false en caso de que sea un muro o que ya este siendo recorrida
     */

    public static boolean isLegal(pos p, int[][] mat){
        return p.fila < 5 && p.columna < 5 && p.fila >= 0 && p.columna >= 0 && mat[p.fila][p.columna] == 0;
    }

    //Posicion final. La salida del laberinto
    public final static pos POS_FIN = new pos(0,SIZE-1);

    /**
     *
     * @param lab : en cada llamada recursiva vamos expandiendo el arbol del backTracking
     * @param currentP posicion que vamos a ramificar para encontrar la solucion
     * @return true si el problema tiene solucion; false en caso contrario
     */

    public static boolean backTrack(int[][] lab, pos currentP){

        boolean haySol = false;
        if(POS_FIN.equals(currentP)) haySol = true;
        int e = 0;

        while(!haySol && e < 4){

            if(isLegal(currentP.next(e),lab)){
                pos aux = currentP.next(e);
                lab[aux.fila][aux.columna] = 1;
                haySol = backTrack(lab,aux);
                if(!haySol) lab[aux.fila][aux.columna] = 0;
            }
            e++;
        }

        return haySol;

    }

    /**
     * Clase creada para mostrar por pantalla las soluciones (no consola, forma mas grafica)
     */

    private static class window extends JFrame{

        /**
         *
         * @param f matriz a mostrar
         * @param s titulo de la "ventana"
         */

        public window(int[][] f,String s){

            super(s);

            //En caso de no haber solucion la matriz recibida sera igual a "null". Por tanto mostraremos que no hay ninguna solucion
            //En otro caso mostramos la matriz pasada como parametro

            if(f == null){
                setLayout(new BorderLayout());
                add(new JLabel("There isn't any solution",SwingConstants.CENTER),BorderLayout.CENTER);
            }else{
                setLayout(new GridLayout(SIZE, SIZE, 2, 2));
                JLabel l1 ;
                for(int i = 0;i < SIZE;i++){
                    for(int j = 0; j < SIZE;j++){
                        switch(f[i][j]){
                            case(-1): l1 = new JLabel("x",SwingConstants.CENTER);l1.setForeground(Color.RED);add(l1);break;
                            case(0): l1 = new JLabel("o",SwingConstants.CENTER);l1.setForeground(Color.BLACK);add(l1);break;
                            default: l1 = new JLabel("-",SwingConstants.CENTER);l1.setForeground(Color.green);l1.setFont(new Font("Serif",Font.PLAIN,40));add(l1);break;
                        }
                    }
                }
            }
            setSize(400,400);
            setVisible(true);
            setDefaultCloseOperation(EXIT_ON_CLOSE);
        }

    }

    public static void main(String[] args) {

        int[][] lab = new int[SIZE][SIZE];
        fill(lab);

        //-----------------------------------------------------------
        // Insertamos las posiciones que queremos que sean obstáculos

        lab[0][0] = -1;
        lab[0][1] = -1;
        lab[1][1] = -1;
        lab[2][1] = -1;
        lab[4][0] = -1;
        lab[1][2] = -1;
        lab[2][3] = -1;
        lab[3][3] = -1;
        //lab[4][3] = -1;

        //-----------------------------------------------------------


        /*
         * En primer lugar creamos una ventana con el contenido del problema sin resolver.
         * Posteriormente empleando backTracking resolvemos el problema, encontrando una solucion la cual
         * se mostrará al usuario mediante la creacion de otra ventana con el "tablero" actualizado.
         */

        window p = new window(lab,"Unsolved Problem");

        //Definimos la posicion inicial en el tablero y realizamos la llamada inicial a "backTrack"

        pos ini = new pos(SIZE-1,0);
        boolean haySol = backTrack(lab,ini);

        if(haySol){
            window w = new window(lab,"Solved Problem");
        }else{
            window w = new window(null," ");
        }





    }


}
