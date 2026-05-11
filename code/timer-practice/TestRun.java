public class TestRun {
    public static void main(String[] args) {
        System.out.println("Testing Java execution...");
        javax.swing.JFrame frame = new javax.swing.JFrame("Test");
        frame.setSize(300, 200);
        frame.setDefaultCloseOperation(javax.swing.JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        System.out.println("Frame should be visible now");
    }
}
