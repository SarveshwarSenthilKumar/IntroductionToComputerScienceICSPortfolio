import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class MenuOrderApp extends JFrame {

    // 1. Declare a checkbox for each menu item
    private JCheckBox pizzaCheckBox;
    private JCheckBox burgerCheckBox;
    private JCheckBox saladCheckBox;
    private JCheckBox sodaCheckBox;

    // 2. Declare the button
    private JButton showOrderButton;

    public MenuOrderApp() {
        // 3. Set up JFrame - this part is done for you.
        setTitle("Menu Order App");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(300, 200);
        setLocationRelativeTo(null);
        setLayout(new FlowLayout());

        JLabel label = new JLabel("Your order will show up here.");

        // 4. Initialize the checkbox
        pizzaCheckBox = new JCheckBox("Pizza");
        burgerCheckBox = new JCheckBox("Burger");
        saladCheckBox = new JCheckBox("Salad");
        sodaCheckBox = new JCheckBox("Soda");
        // 5. Initialize the button
        showOrderButton = new JButton("Show Order");

        // 6. Add components to JFrame
        add(pizzaCheckBox);
        add(burgerCheckBox);
        add(saladCheckBox);
        add(sodaCheckBox);

        add(showOrderButton);

        add(label);


        // 7. Add event handler for button
        showOrderButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // You should:
                String selectedItems = "";

                // Check which checkboxes are selected
                if (pizzaCheckBox.isSelected()) {
                    System.out.println("Pizza is selected");
                    selectedItems += "Pizza ";
                }
                if (burgerCheckBox.isSelected()) {
                    System.out.println("Burger is selected");
                    selectedItems += "Burger ";
                }
                if (saladCheckBox.isSelected()) {
                    System.out.println("Salad is selected");
                    selectedItems += "Salad ";
                }
                if (sodaCheckBox.isSelected()) {
                    System.out.println("Soda is selected");
                    selectedItems += "Soda ";
                }

                // Build a string with selected items
                // Display result using JLabel (hint: use setText())
                label.setText("You ordered: " + selectedItems);
            }
        });
    }

    public static void main(String[] args) {
        // 8. Run GUI
			MenuOrderApp app = new MenuOrderApp();
            app.setVisible(true);
    }
}
