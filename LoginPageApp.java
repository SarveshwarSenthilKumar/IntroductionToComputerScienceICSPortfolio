import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class LoginPageApp extends JFrame {

    // 1. Declare components
    private JTextField userIdField;
    private JPasswordField passwordField;
    private JButton submitButton;

    public LoginPageApp() {

        // 2. Frame setup
        setTitle("Login Page");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setSize(400, 250);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        // 3. Main panel (acts like content container)
        JPanel mainPanel = new JPanel();
        mainPanel.setLayout(new BorderLayout());
        mainPanel.setBorder(BorderFactory.createEmptyBorder(20, 30, 20, 30));

        // 4. Form panel (GridBag for alignment)
        JPanel formPanel = new JPanel();
        formPanel.setLayout(new GridBagLayout());
        GridBagConstraints gbc = new GridBagConstraints();

        gbc.insets = new Insets(10, 10, 10, 10); // spacing

        // 5. User ID Label
        gbc.gridx = 0;
        gbc.gridy = 0;
        gbc.anchor = GridBagConstraints.WEST;
        formPanel.add(new JLabel("User ID:"), gbc);

        // 6. User ID Field
        gbc.gridx = 1;
        userIdField = new JTextField(15);
        formPanel.add(userIdField, gbc);

        // 7. Password Label
        gbc.gridx = 0;
        gbc.gridy = 1;
        formPanel.add(new JLabel("Enter Password:"), gbc);

        // 8. Password Field
        gbc.gridx = 1;
        passwordField = new JPasswordField(15);
        formPanel.add(passwordField, gbc);

        // 9. Button panel (centered button)
        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER));

        submitButton = new JButton("submit");
        buttonPanel.add(submitButton);

        // 10. Add panels to main panel
        mainPanel.add(formPanel, BorderLayout.CENTER);
        mainPanel.add(buttonPanel, BorderLayout.SOUTH);

        // 11. Add main panel to frame
        add(mainPanel, BorderLayout.CENTER);

        // 12. Event handling
        submitButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String userId = userIdField.getText();
                String password = new String(passwordField.getPassword());

                System.out.println("User ID: " + userId);
                System.out.println("Password: " + password);

                JOptionPane.showMessageDialog(null,
                        "Login Attempt:\nUser ID: " + userId);
            }
        });
    }

    public static void main(String[] args) {
        LoginPageApp app = new LoginPageApp();
        app.setVisible(true);
    }
}