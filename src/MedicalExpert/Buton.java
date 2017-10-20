package MedicalExpert;

import java.awt.Color;
import javax.swing.JButton;

/**
 *
 * @author Catalin
 */
public class Buton extends JButton
{

    @SuppressWarnings("OverridableMethodCallInConstructor")
    public Buton()
    {
        setFont(new java.awt.Font("Monaco", 1, 13));
        setBackground(new Color(0x214072));
        setForeground(new Color(255,255,255,150));
        setUI(new StilButon());
    }
}
