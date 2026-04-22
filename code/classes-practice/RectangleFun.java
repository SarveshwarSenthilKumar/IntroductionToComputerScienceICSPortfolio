public class RectangleFun {
    public static void main(String[] args) {
        MyRectangle rect1 = new MyRectangle();
        MyRectangle rect2 = new MyRectangle(5, 3, "inches");
        System.out.println("The perimeter of the rectangle is " + rect2.calculatePerimeter());
        System.out.println("The Area of the rectangle is " + rect2.calculateArea());
        System.out.println("Is this rectangle a square?: " + rect2.checkSquare());
    }
}