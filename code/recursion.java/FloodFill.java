public class FloodFill {
    // attributes
    public char[][] grid;
    
    // constructor method which initializes grid
    public FloodFill(char[][] grid){
        this.grid = grid;
    }
    
    void fill(int row, int col, char target, char replacement){
        // checking if the row or column numbers are invalid
        if (row<0 || row>=this.grid.length ||
            col<0 || col>=this.grid[0].length) {
            return;
        }
        
        // if the given coordinate is not target, return void
        if (this.grid[row][col] != target) {
            return;
        }
        
        // changing the current coordinate to the replacement
        this.grid[row][col] = replacement;
        
        // recursively checking the blocks around the coordinate
        fill(row - 1, col, target, replacement);
        fill(row + 1, col, target, replacement);
        fill(row, col - 1, target, replacement); 
        fill(row, col + 1, target, replacement); 
    }
    
    public void printGrid(){
        // iterating through each row and column and printing out the value
        for (int i=0;i<this.grid.length;i++){
            System.out.println();
            for (int j=0;j<this.grid[i].length;j++){
                System.out.print(this.grid[i][j] + " ");
            }
        }
    }
}