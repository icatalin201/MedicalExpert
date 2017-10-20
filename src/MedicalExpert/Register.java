package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.ButtonGroup;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPasswordField;
import javax.swing.JRadioButton;
import javax.swing.JTextField;
import javax.swing.SwingConstants;

/**
 *
 * @author Catalin
 */
public class Register extends JFrame
{
    Buton register;
    JLabel iesire;
    JLabel fundal;
    JLabel cadru;
    JLabel text;
    JTextField user;
    JTextField fname;
    JTextField lname;
    JTextField age;
    JPasswordField pass;
    JLabel label_user;
    JLabel label_pass;
    JLabel label_nume;
    JLabel label_prenume;
    JLabel label_varsta;
    JLabel label_sex;
    JRadioButton m;
    JRadioButton f;
    ButtonGroup grup;
    private static final JFrame frame = new Register();
    public static boolean verifica = true;
  
    @SuppressWarnings("OverridableMethodCallInConstructor")
    public Register()
    {
        register = new Buton();
        iesire = new JLabel();
        fundal = new JLabel();
        cadru = new JLabel();
        text = new JLabel();
        user = new JTextField();
        pass = new JPasswordField();
        fname = new JTextField();
        lname = new JTextField();
        age = new JTextField();
        label_user = new JLabel();
        label_pass = new JLabel();
        label_nume = new JLabel();
        label_prenume = new JLabel();
        label_varsta = new JLabel();
        label_sex = new JLabel();
        m = new JRadioButton();
        f = new JRadioButton();
        grup = new ButtonGroup();
        
        text.setBounds(240,50,130,30);
        text.setText("INREGISTRARE");
        text.setFont(new Font("Monaco", Font.BOLD, 16));
        
        user.setBounds(140,130,145,30);
        user.setBorder(null);
        user.setHorizontalAlignment(SwingConstants.CENTER);
        user.setFont(new Font("Monaco", Font.ITALIC, 16));
        user.setBackground(new Color(0x80a0f7));
        
        label_user.setBounds(140,100,90,30);
        label_user.setText("Nume utilizator");
        label_pass.setBounds(320,100,90,30);
        label_pass.setText("Parola");
        label_nume.setText("Nume");
        label_prenume.setText("Prenume");
        label_sex.setText("Sex");
        label_varsta.setText("Varsta");
        label_nume.setBounds(140,170,90,30);
        label_prenume.setBounds(320,170,90,30);
        label_varsta.setBounds(140,240,90,30);
        grup.add(f);
        grup.add(m);
        f.setBounds(320,270,50,30);
        m.setBounds(390,270,50,30);
        f.setText("F");
        m.setText("M");
        label_sex.setBounds(320,240,90,30);
        f.setBackground(new Color(0x80a0f7));
        m.setBackground(new Color(0x80a0f7));
        f.setHorizontalAlignment(SwingConstants.CENTER);
        m.setHorizontalAlignment(SwingConstants.CENTER);
        
        pass.setBounds(320,130,145,30);
        pass.setBorder(null);
        pass.setHorizontalAlignment(SwingConstants.CENTER);
        pass.setFont(new Font("Monaco", Font.BOLD, 16));
        pass.setBackground(new Color(0x80a0f7));
        
        fname.setBounds(140,200,145,30);
        fname.setBorder(null);
        fname.setHorizontalAlignment(SwingConstants.CENTER);
        fname.setFont(new Font("Monaco", Font.ITALIC, 16));
        fname.setBackground(new Color(0x80a0f7));
                
        lname.setBounds(320,200,145,30);
        lname.setBorder(null);
        lname.setHorizontalAlignment(SwingConstants.CENTER);
        lname.setFont(new Font("Monaco", Font.ITALIC, 16));
        lname.setBackground(new Color(0x80a0f7));
        
        age.setBounds(140,270,145,30);
        age.setBorder(null);
        age.setHorizontalAlignment(SwingConstants.CENTER);
        age.setFont(new Font("Monaco", Font.ITALIC, 16));
        age.setBackground(new Color(0x80a0f7));
                
        cadru.setBounds(20,20,560,460);
        cadru.setOpaque(true);
        cadru.setBackground(new Color(255,255,255,150));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        

        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg1.jpg")));
        fundal.setBounds(0, 0, 600, 500);
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        
        iesire = new JLabel();
        iesire.setBounds(540,30,25,25);
        iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close.png")));
        iesire.addMouseListener(new MouseAdapter(){
            
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close-hover.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                iesire.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/close.png")));
            }
            
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                System.exit(0);
            }
        });
        
        register.setText("Inregistrare");
        register.setBounds(230, 400, 150, 30);
        register.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Register(evt);
            }
        });
        register.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                register.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                register.setForeground(new Color(255,255,255,150));
            }
        });
        initializare();
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(600, 500));
        setPreferredSize(new java.awt.Dimension(600, 500));
        setResizable(false);
        setUndecorated(true);
        getContentPane().setLayout(null);
        getContentPane().add(iesire);
        getContentPane().add(text);
        getContentPane().add(f);
        getContentPane().add(m);
        getContentPane().add(label_user);
        getContentPane().add(label_pass);
        getContentPane().add(label_nume);
        getContentPane().add(label_prenume);
        getContentPane().add(label_varsta);
        getContentPane().add(label_sex);
        getContentPane().add(register);
        getContentPane().add(fname);
        getContentPane().add(lname);
        getContentPane().add(age);
        getContentPane().add(user);
        getContentPane().add(pass);
        getContentPane().add(cadru);             
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
        setVisible(true);
    }
    
    public static boolean Verifica(){
        return verifica;
    }
    
    public static final JFrame getMainFrame(){
        return frame;
    }
    
    private void Register(java.awt.event.ActionEvent evt)
    { // buton inregistrare
        String sex = "";
        if(f.isSelected())
        {
            sex = "F";
        }
        else if(m.isSelected())
        {
            sex = "M";
        }
        try 
        {
            ConexiuneDB.Inregistrare(user, pass, fname, lname, age, sex);
        } 
        catch (ClassNotFoundException ex) {}
    }
}
