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

        // 4. Initialize the checkbox
        pizzaCheckBox = new JCheckBox("Pizza");

        // 5. Initialize the button
        showOrderButton = new JButton("Show Order");

        // 6. Add components to JFrame
        add(pizzaCheckBox);
        // Students: Add more checkboxes here
        add(showOrderButton);

        // 7. Add event handler for button
        showOrderButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                // You should:
                // Check which checkboxes are selected
                // Build a string with selected items
                // Display result using JLabel (hint: use setText())
            }
        });
    }

    public static void main(String[] args) {
        // 8. Run GUI
			MenuOrderApp app = new MenuOrderApp();
            app.setVisible(true);
    }
}
