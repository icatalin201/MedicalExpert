package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextPane;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;

/**
 *
 * @author Catalin
 */
public class Functionare extends JFrame {
    
    JLabel fundal;
    JLabel cadru_mare;
    JLabel cadru_mic;
    Buton inapoi;
    JPanel panou;
    JScrollPane scroll;
    JTextPane txt;
    
    public Functionare()
    {
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        fundal = new JLabel();
        cadru_mare = new JLabel();
        cadru_mic = new JLabel();
        inapoi = new Buton();
        panou = new JPanel();
        scroll = new JScrollPane();
        txt = new JTextPane();
        
        cadru_mic.setBounds(20,10,760,120);
        cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/func-opac.png")));
        cadru_mic.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        cadru_mic.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/func.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/func-opac.png")));
            }
        });
        
        cadru_mare.setBounds(20,140,760,410);
        //cadru.setOpaque(true);
        //cadru.setBackground(new Color(255,255,255,100));
        cadru_mare.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru_mare.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());

        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        inapoi.setText("Inapoi");
        inapoi.setBounds(650, 350, 80, 30);
        inapoi.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Inapoi(evt);
            }
        });
        inapoi.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                inapoi.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                inapoi.setForeground(new Color(255,255,255,150));
            }
        });
        panou.setLayout(null);
        panou.add(inapoi);
        panou.add(scroll);
        panou.setBounds(30,150,740,390);
        panou.setOpaque(true);
        panou.setBackground(new Color(255,255,255,0));
        
        txt.setEditable(false);
        txt.setFont(new Font("Monaco", Font.PLAIN, 15));
        txt.setMargin(new Insets(20, 30, 30, 30));
        txt.setOpaque(true);
        txt.setBackground(new Color(255,255,255,200));
        scroll.setViewportView(txt);
        scroll.setBorder(null);
        scroll.setBounds(0,0,740,390);
        txt.setText("Inainte de a utiliza aplicatia trebuie sa se tina cont de limitarile pe care "
                + "baza de cunostinte le are in stadiul actual, bolile ce pot fi identificate "
                + "fiind urmatoarele: Viroza Respiratorie, Gripa, Apnee Obstructiva, Astm Bronsic, Faringita, "
                + "Bronsita, Candidoza Bucala, "
                + "Ulcer Gastroduodenal, Toxiinfectie Alimentara, Apendicita, Gastrita, Litiaza Biliara, "
                + "Enterocolita. De asemenea, un lucru important de care trebuie sa se tina cont este ca "
                + "aplicatia nu a fost conceputa sa inlocuiasca consultul medical de specialitate.\n\n"
                + "Aplicatia MedicalExpert este un Sistem Expert ce preia de la utilizator simptomele acestuia "
                + "si le atribuie valori de la 0 la 10, valori denumite ponderi. In cazul in care un simptom"
                + " are ponderea 0 pentru un anumit diagnostic inseamna ca acesta nu este de luat in calcul "
                + "pentru acel diagnostic, iar daca are ponderea 10 inseamna ca acel simptom este foarte"
                + " important pentru acea boala."
                + " Practic, aceste ponderi reprezinta importanta simptomului pentru diagnosticul final. \n\n"
                + "Aplicatia interogheaza in permanenta baza de cunostinte in vederea existentei unui diagnostic "
                + "dat de simptomele preluate. Cand diagnosticul este gasit, este afisat utilizatorului un "
                + "mesaj de informare ce va contine numele afectiunii si procentul acesteia, impreuna cu un link"
                + " catre fereastra de recomandari. Periodic aplicatia va intreba utilizatorul daca doreste sa "
                + "refaca testul pentru a-si reverifica starea in vederea ameliorarii afectiunii sale.");
        SimpleAttributeSet atribut = new SimpleAttributeSet();
        StyleConstants.setAlignment(atribut, StyleConstants.ALIGN_JUSTIFIED);
        txt.getStyledDocument().setParagraphAttributes(txt.getHeight(), txt.getWidth(), atribut, false);
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        setResizable(false);
        getContentPane().setLayout(null);
        getContentPane().add(panou);
        getContentPane().add(cadru_mic); 
        getContentPane().add(cadru_mare);   
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
    }
    
    private void Inapoi(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Acasa().setVisible(true);
    }
}
