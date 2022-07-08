import java.util.Objects;
import javax.swing.*;
import java.awt.*;


/**
 * Autor : Aleph8 (GitHub)
 * Descripcion: small program that solves any labyrinth you enter
 * Fecha: 30-01-2022
 */


public class BackT_Laberinto {

    //Set the size of the board
    final static int SIZE = 10;
    private int[][] SOLVED;

    //Final position. The exit of the labyrinth
    private final static pos POS_FIN = new pos(1,SIZE-1);
    //Initial position. Entrance to the labyrinth
    private final static pos POS_INI = new pos(SIZE-2,0);

    /**
     *
     * @param matriz : matriz a mostrar.
     *  The method is a simple path shown by console, used auxiliary in the development of the code.
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
     * Auxiliary class created to control the status of the backTracking as well as to facilitate the next position.
     */

    private static class pos{

        private int fila,columna;
        public pos(int f,int c){
            fila = f;
            columna = c;
        }

        /**
         *
         * @param e: current pos
         * @return next pos
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
         *We define again both the equals method and the hashCode. 
         * In this way we can unambiguously compare two objects of the created class.
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
     * @param matriz: we fill the whole matrix with zeros
     */

    public static void fill(int[][] matriz){
        for(int i = 0;i < SIZE;i++){
            for(int j = 0;j< SIZE;j++){
                matriz[i][j] = 0;
            }
            System.out.println();
        }
    }

    /**
     *
     * @param p: position we want to check
     * @param mat:  array where we check if p is equal to zero; if so the backTracking can continue there.
     * @return true if equal to zero; false in case it is a wall or is already being traversed.
     */

    public static boolean isLegal(pos p, int[][] mat){
        return p.fila < SIZE && p.columna < SIZE && p.fila >= 0 && p.columna >= 0 && mat[p.fila][p.columna] == 0;
    }



    /**
     *
     * @param lab : in each recursive call we expand the backTracking tree
     * @param currentP position we are going to branch to find the solution
     * @return true if the problem is solvable; false otherwise
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
                if(!haySol) lab[aux.fila][aux.columna] = -3;
            }
            e++;
        }
        return haySol;
    }

    /**
     * Class created to display the solutions on the screen (not console, more graphical way)
     */



    private static class window extends JFrame{

        /**
         * A small auxiliary method to avoid repeating so much code.
         * @param j label to be modified
         * @param back background color of the label
         * @param let font color
         */

        protected void backGround(JLabel j, Color back,Color let){
            j.setOpaque(true);
            j.setBackground(back);
            j.setForeground(let);
        }

        /**
         *
         * @param f matrix to be displayed
         * @param s title of the "window".
         */

        public window(int[][] f,String s){

            super(s);

            //In case there is no solution the received matrix will be equal to "null". Therefore we will show that there is no solution.
            //In another case we show the matrix passed as a parameter

            if(f == null){
                setLayout(new BorderLayout());
                add(new JLabel("There isn't any solution",SwingConstants.CENTER),BorderLayout.CENTER);
            }else{
                setLayout(new GridLayout(SIZE, SIZE, 0, 0));
                JLabel l1 ;
                for(int i = 0;i < SIZE;i++){
                    for(int j = 0; j < SIZE;j++){
                        if((POS_INI.fila == i && POS_INI.columna ==j)||(POS_FIN.fila == i && POS_FIN.columna == j)){
                            l1 = new JLabel("o",SwingConstants.CENTER); backGround(l1,Color.WHITE,Color.yellow);
                            l1.setFont(new Font("Serif",Font.PLAIN,30));add(l1);
                        }else{
                            switch(f[i][j]){
                                case(-1): l1 = new JLabel();backGround(l1,Color.black,Color.black);add(l1);break;
                                case(0): l1 = new JLabel();backGround(l1,Color.white,Color.white);add(l1);break;
                                case(-3): l1 = new JLabel("-",SwingConstants.CENTER);backGround(l1,Color.white,Color.RED);
                                ;l1.setFont(new Font("Serif",Font.PLAIN,40));add(l1);break;
                                default: l1 = new JLabel("-",SwingConstants.CENTER);backGround(l1,Color.white,Color.GREEN);
                                l1.setFont(new Font("Serif",Font.PLAIN,40));add(l1);break;
                            }
                        }
                    }
                }
            }
            setSize(500,500);
            setVisible(true);
            setDefaultCloseOperation(EXIT_ON_CLOSE);
        }

    }

    public static void main(String[] args) {

        int[][] lab = new int[SIZE][SIZE];
        fill(lab);

        //-----------------------------------------------------------
        // We insert the positions that we want to be obstacles by assigning a "-1" in the array

        lab[1][0] = -1;lab[1][1] = -1;lab[5][0] = -1;lab[5][1] = -1;lab[6][1] = -1;lab[7][1] = -1;lab[8][1] = -1;
        lab[3][1] = -1;lab[3][2]=-1;lab[3][3] = -1;lab[4][3] = -1;lab[5][3] = -1;lab[2][3] = -1;lab[1][3] = -1;
        lab[1][4] = -1;lab[1][5] = -1;lab[0][5] =-1;lab[2][5] = -1;lab[9][3] = -1;lab[7][3] = -1;lab[7][4] = -1;
        lab[7][5] = -1;lab[8][5] = -1; lab[9][5] = -1; lab[6][5] = -1;lab[7][6] = -1; lab[7][7] = -1;lab[7][8] = -1;lab[8][8] = -1;
        lab[4][5] = -1;lab[4][6] = -1;lab[4][7] = -1;lab[5][7] = -1;lab[5][8] = -1;lab[3][7] = -1;lab[3][9] = -1;lab[2][7] = -1;
        lab[1][7] = -1;lab[0][7] = -1;lab[1][8] = -1;

        //-----------------------------------------------------------


        /*
         *First we create a window with the contents of the unsolved problem.
         * Then using backTracking we solve the problem, finding a solution which will be shown to the user by creating another window with the updated "dashboard".
         *  will be shown to the user by creating another window with the updated "dashboard".
         */

        window p = new window(lab,"Unsolved Problem");
        lab[POS_INI.fila][POS_INI.columna] = 1;


        boolean haySol = backTrack(lab,POS_INI);

        if(haySol){
            window w = new window(lab,"Solved Problem");
        }else{
            window w = new window(null," ");
        }

    }


}
