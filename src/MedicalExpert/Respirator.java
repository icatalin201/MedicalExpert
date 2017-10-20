package MedicalExpert;

import net.sf.clipsrules.jni.*;
import java.awt.Color;
import java.awt.Toolkit;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import static MedicalExpert.Start.user;
import java.awt.Insets;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/**
 *
 * @author Catalin
 */
public class Respirator extends JFrame 
{
    Environment clips;
    JLabel intrebare;
    JLabel fundal;
    JLabel contur;
    JLabel auxiliar;
    Buton da;
    Buton nu;  
    Buton aux;
    JTextArea panou;
    JLabel labelpanou;
    JScrollPane scroll;
    Buton inapoi;
    Buton restart;
    JLabel cadru;
    JLabel cadru_mic;
    JLabel panou_lateral;
    JLabel contur_panou;
    JLabel nume_lateral;
    Buton profil;
    JLabel diag_curent;
    JLabel diag;
    JLabel bara;
    JLabel recomandare;
    Buton rec;
       
    @SuppressWarnings("Convert2Lambda")
    public Respirator()
    {
        proprietati_obiecte();
        initializare();
    }
    
    private void proprietati_obiecte()
    {
        clips = new Environment();
        clips.load("respirator.clp");
        clips.reset(); 
        clips.run();
        
        nume_lateral = new JLabel();
        profil = new Buton();
        diag_curent = new JLabel();
        diag = new JLabel();
        bara = new JLabel();
        recomandare = new JLabel();
        rec = new Buton();
        nume_lateral.setBounds(590,150,180,80);
        try { ConexiuneDB.UserNameLateral(user, nume_lateral);} 
        catch (ClassNotFoundException ex) {}
        nume_lateral.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        nume_lateral.setBackground(new Color(255,255,255,200));
        nume_lateral.setOpaque(true);
        nume_lateral.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        
        profil.setBounds(610,250,140,30);
        profil.setText("Editeaza datele");
        profil.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                profil.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                profil.setForeground(new Color(255,255,255,150));
            }
        });
        profil.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Editare(evt);
            }
        });
        
        bara.setBounds(590,300,180,1);
        bara.setBorder(javax.swing.BorderFactory.createLineBorder(Color.GRAY));
        
        diag_curent.setBounds(590,301,180,40);
        diag_curent.setOpaque(true);
        diag_curent.setBackground(new Color(255, 255, 255, 200));
        diag_curent.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        diag_curent.setText("Diagnostic curent");
        diag.setBounds(590,341,180,40);
        diag.setOpaque(true);
        diag.setBackground(new Color(255, 255, 255, 200));
        diag.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        recomandare.setBounds(590,381,180,100);
        recomandare.setOpaque(true);
        recomandare.setBackground(new Color(255, 255, 255, 200));
        recomandare.setVerticalAlignment(JLabel.TOP);
        recomandare.setVerticalTextPosition(JLabel.TOP);
        recomandare.setHorizontalAlignment(JLabel.CENTER);
        recomandare.setHorizontalTextPosition(JLabel.CENTER);
        try { ConexiuneDB.Diagnostic_curent(user, diag, recomandare);} 
        catch (ClassNotFoundException ex) {}
        rec.setBounds(610,440,140,30);
        rec.setText("Vezi mai multe");
        rec.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                rec.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                rec.setForeground(new Color(255,255,255,150));
            }
        });
        rec.addActionListener(new java.awt.event.ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                Recomandari(evt);
            }
        });
        if(diag.getText().contains("diagnostic inexistent"))
        {
            rec.setVisible(false);
        }
        
        inapoi = new Buton();
        inapoi.setText("Inapoi");
        inapoi.setBounds(610, 495, 140, 30);
        inapoi.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                butonInapoi(evt);
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
        
        restart = new Buton();
        restart.setBounds(230,350,140,30);
        restart.setText("Continua");
        restart.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                butonRestart(evt);
            }
        });
        restart.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                restart.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                restart.setForeground(new Color(255,255,255,150));
            }
        });
               
        da = new Buton();
        da.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                da(evt);
            }
        });
        da.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                da.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                da.setForeground(new Color(255,255,255,150));
            }
        });
        
        nu = new Buton();
        nu.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                nu(evt);
            }
        });
        nu.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                nu.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                nu.setForeground(new Color(255,255,255,150));
            }
        });
        
        aux = new Buton();
        aux.addActionListener(new java.awt.event.ActionListener() {            
            @Override
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                aux(evt);
            }
        });
        aux.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                aux.setForeground(new Color(255,255,255,255));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                aux.setForeground(new Color(255,255,255,150));
            }
        });
        
        fundal = new JLabel();
        fundal.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/start.jpg")));
        fundal.setBounds(0, 0, 800, 600);
        
        cadru = new JLabel();
        cadru.setBounds(20,140,550,410);
        cadru.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        cadru.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        cadru_mic = new JLabel();
        cadru_mic.setBounds(20,10,760,120);
        cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lg-opac.png")));
        cadru_mic.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        cadru_mic.addMouseListener(new MouseAdapter(){
            @Override
            public void mouseEntered(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lg.png")));
            }
            
            @Override
            public void mouseExited(MouseEvent arg0)
            {
                cadru_mic.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/lg-opac.png")));
            }
        });
        
        panou_lateral = new JLabel();
        panou_lateral.setBounds(580,140,200,410);
        panou_lateral.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pics/bg.png")));
        panou_lateral.setBorder(javax.swing.BorderFactory.createRaisedBevelBorder());
        
        contur_panou = new JLabel();
        contur_panou.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        contur_panou.setBounds(590, 150, 180, 390);
        contur_panou.setOpaque(true);
        contur_panou.setBackground(new Color(255, 255, 255, 150));
         
        contur = new JLabel();
        contur.setBorder(javax.swing.BorderFactory.createLoweredSoftBevelBorder());
        contur.setBounds(30, 150, 530, 180);
        contur.setOpaque(true);
        contur.setBackground(new Color(255, 255, 255, 150));
        
        panou = new JTextArea();
        panou.setText(" Raspunsurile dumneavoastra sunt afisate mai jos: " + "\r\n");
        panou.setFont(new java.awt.Font("Monaco", 0, 15));       
        panou.setEditable(false);
        panou.setBounds(30, 350, 530, 190);
        panou.setOpaque(false);
        panou.setMargin(new Insets(12, 12, 12, 12));
        
        scroll = new JScrollPane();
        scroll.getViewport().setView(panou);
        scroll.setBounds(30, 350, 530, 190);
        scroll.setOpaque(false);
        scroll.getViewport().setOpaque(false);
        scroll.setBorder(javax.swing.BorderFactory.createLoweredBevelBorder());
        
        labelpanou = new JLabel();
        labelpanou.setBounds(30, 350, 530, 190);
        labelpanou.setOpaque(true);
        labelpanou.setBackground(new Color(255, 255, 255, 150));
                             
        intrebare = new JLabel();
        intrebare.setBounds(30, 150, 530, 110);
        intrebare.setFont(new java.awt.Font("Monaco", 0, 15));
        intrebare.setBorder(javax.swing.BorderFactory.createLoweredBevelBorder());
        intrebare.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        intrebare.setText("<html><p align=center>Acest modul poate diagnostica cu succes bolile:<br>"
                + "Apnee-Obstructiva, Astm-Bronsic, Bronsita, Faringita, Gripa, Viroza</p></html>");
        
        auxiliar = new JLabel();
        auxiliar.setBounds(30, 170, 530, 100);
        auxiliar.setFont(new java.awt.Font("Monaco", 0, 15));
        auxiliar.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        
        da.setText("DA");
        nu.setText("NU");
        da.setOpaque(false);
        nu.setOpaque(false);
        da.setBounds(190, 280, 100, 25);
        nu.setBounds(300, 280, 100, 25);
        aux.setOpaque(false);
        aux.setBounds(410, 280, 100, 25);
        
        da.setVisible(false);
        nu.setVisible(false);
        aux.setVisible(false);
        panou.setVisible(false);
        scroll.setVisible(false);
        labelpanou.setVisible(false);
        restart.setVisible(true);
    }
    
    private void initializare()
    {
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));
        setIconImage(Toolkit.getDefaultToolkit().getImage(getClass().getResource("/pics/logo-mare.png")));
        setResizable(false);  
        getContentPane().setLayout(null);
        getContentPane().add(da);
        getContentPane().add(nu);
        getContentPane().add(aux);
        getContentPane().add(inapoi);       
        getContentPane().add(restart);
        getContentPane().add(scroll);
        getContentPane().add(labelpanou);
        getContentPane().add(intrebare);        
        getContentPane().add(auxiliar);
        getContentPane().add(contur);
        getContentPane().add(rec);
        getContentPane().add(recomandare);
        getContentPane().add(bara);
        getContentPane().add(diag);
        getContentPane().add(diag_curent);
        getContentPane().add(profil);
        getContentPane().add(nume_lateral);
        getContentPane().add(contur_panou);
        getContentPane().add(panou_lateral);
        getContentPane().add(cadru_mic);
        getContentPane().add(cadru);
        getContentPane().add(fundal);
        setLocationRelativeTo(null);
        pack();
        setVisible(true);
    }
    
    public void butonRestart(java.awt.event.ActionEvent evt) 
    {
        if(intrebare.getText().contains("Diagnosticarea"))
        {
            this.setVisible(false);
            new Asistent().setVisible(true);
        }
        else 
        {
            setare_obiecte_start();
            try
            {             
                primire_intrebari();
            }
            catch(Exception ex)
            {
            ex.printStackTrace();
            }
            restart.setVisible(false);
        }
        
    }
    
    public void butonInapoi(java.awt.event.ActionEvent evt) 
    {
        this.setVisible(false);
        clips.destroy();
        new Acasa().setVisible(true);
    }
    public void da(java.awt.event.ActionEvent evt) 
    {
        setare_obiecte_start();
        try
        {       
            clips.eval("(assert (raspuns da))");
                
            if(intrebare.getText().contains("obosit"))
                panou.setText(panou.getText() + "\r\n" + " oboseala = da");
            if(intrebare.getText().contains("senzatia de tuse"))
                panou.setText(panou.getText() + "\r\n" + " tuse = da");
            if(intrebare.getText().contains("criza"))
                panou.setText(panou.getText() + "\r\n" + " criza de tuse = da");
            if(intrebare.getText().contains("dureri in piept in timpul tusei"))
                panou.setText(panou.getText() + "\r\n" + " dureri in piept in timpul tusei = da");
            if(intrebare.getText().contains("sange"))
                panou.setText(panou.getText() + "\r\n" + " tuse insotita de eliminari de sange = da");
            if(intrebare.getText().contains("seaca"))
                panou.setText(panou.getText() + "\r\n" + " tuse seaca = da");
            if(intrebare.getText().contains("Sforaiti"))
                panou.setText(panou.getText() + "\r\n" + " sforait = da");
            if(intrebare.getText().contains("urina"))
                panou.setText(panou.getText() + "\r\n" + " pierderi necontrolate de urina pe timpul noptii = da");
            if(intrebare.getText().contains("abundent"))
                panou.setText(panou.getText() + "\r\n" + " transpiratii abundente noaptea = da");
            if(intrebare.getText().contains("obezitate"))
                panou.setText(panou.getText() + "\r\n" + " obezitate = da");
            if(intrebare.getText().contains("tulburari comportamentale"))
                panou.setText(panou.getText() + "\r\n" + " tulburari de comportament = da");
            if(intrebare.getText().contains("somnolenta"))
                panou.setText(panou.getText() + "\r\n" + " somnolenta diurna = da");
            if(intrebare.getText().contains("febra"))
                panou.setText(panou.getText() + "\r\n" + " febra = da");
            if(intrebare.getText().contains("este usoara"))
                panou.setText(panou.getText() + "\r\n" + " febra usoara = da");
            if(intrebare.getText().contains("frisoane"))
                panou.setText(panou.getText() + "\r\n" + " frisoane = da");
            if(intrebare.getText().contains("musculare"))
                panou.setText(panou.getText() + "\r\n" + " dureri musculare = da");
            if(intrebare.getText().contains("pofta de mancare"))
                panou.setText(panou.getText() + "\r\n" + " lipsa pofta de mancare = da");
            if(intrebare.getText().contains("stare generala de rau"))
                panou.setText(panou.getText() + "\r\n" + " stare generala de rau = da");
            if(intrebare.getText().contains("secretii nazale"))
                panou.setText(panou.getText() + "\r\n" + " secretii nazale = da");
            if(intrebare.getText().contains("voma"))
                panou.setText(panou.getText() + "\r\n" + " voma = da");
            if(intrebare.getText().contains("dureri de cap"))
                panou.setText(panou.getText() + "\r\n" + " dureri de cap = da");
            if(intrebare.getText().contains("dureri in gat"))
                panou.setText(panou.getText() + "\r\n" + " dureri in gat = da");
            if(intrebare.getText().contains("faringiene"))
                panou.setText(panou.getText() + "\r\n" + " inrosire mucoasa faringiana = da");
            if(intrebare.getText().contains("inghitire"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la inghitire = da");
            if(intrebare.getText().contains("olfactiv"))
                panou.setText(panou.getText() + "\r\n" + " perturbarea simtului olfactiv = da");
            if(intrebare.getText().contains("uscaciune"))
                panou.setText(panou.getText() + "\r\n" + " senzatie de uscaciune in gat = da");
            if(intrebare.getText().contains("ganglionilor"))
                panou.setText(panou.getText() + "\r\n" + " inflamare a ganglionilor = da");
            if(intrebare.getText().contains("sufocati"))
                panou.setText(panou.getText() + "\r\n" + " sufocare = da");
            if(intrebare.getText().contains("zgomotoasa"))
                panou.setText(panou.getText() + "\r\n" + " respiratie suieratoare, zgomotoasa = da");
            if(intrebare.getText().contains("dificultate in respiratie"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la respiratie = da");
            if(intrebare.getText().contains("dureri in piept la respiratie"))
                panou.setText(panou.getText() + "\r\n" + " durere in piept in timpul respiratiei = da");
            
            if(intrebare.getText().contains("Febra este usoara"))
            {
                da.setText("Da");
                nu.setText("Nu");
                aux.setVisible(false);
            }
            else if(intrebare.getText().contains("Febra este"))
            {
                da.setText("usoara");
                nu.setText("moderata");
                aux.setVisible(true);
                aux.setText("puternica");
            }
            else if(intrebare.getText().contains("tusei"))
            {
                da.setText("seaca");
                nu.setText("productiva");
            }
            
            primire_intrebari();
            returneaza_diagnostic();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void nu(java.awt.event.ActionEvent evt) 
    {
        setare_obiecte_start();
        try
        {       
            clips.eval("(assert (raspuns nu))");
                
            if(intrebare.getText().contains("productiva"))
                panou.setText(panou.getText() + "\r\n" + " tuse productiva = da");
            if(intrebare.getText().contains("obosit"))
                panou.setText(panou.getText() + "\r\n" + " oboseala = nu");
            if(intrebare.getText().contains("senzatia de tuse"))
                panou.setText(panou.getText() + "\r\n" + " tuse = nu");
            if(intrebare.getText().contains("criza"))
                panou.setText(panou.getText() + "\r\n" + " criza de tuse = nu");
            if(intrebare.getText().contains("dureri in piept in timpul tusei"))
                panou.setText(panou.getText() + "\r\n" + " dureri in piept in timpul tusei = nu");
            if(intrebare.getText().contains("sange"))
                panou.setText(panou.getText() + "\r\n" + " tuse insotita de eliminari de sange = nu");
            if(intrebare.getText().contains("Sforaiti"))
                panou.setText(panou.getText() + "\r\n" + " sforait = nu");
            if(intrebare.getText().contains("urina"))
                panou.setText(panou.getText() + "\r\n" + " pierderi necontrolate de urina pe timpul noptii = nu");
            if(intrebare.getText().contains("abundent"))
                panou.setText(panou.getText() + "\r\n" + " transpiratii abundente noaptea = nu");
            if(intrebare.getText().contains("obezitate"))
                panou.setText(panou.getText() + "\r\n" + " obezitate = nu");
            if(intrebare.getText().contains("tulburari comportamentale"))
                panou.setText(panou.getText() + "\r\n" + " tulburari de comportament = nu");
            if(intrebare.getText().contains("somnolenta"))
                panou.setText(panou.getText() + "\r\n" + " somnolenta diurna = nu");
            if(intrebare.getText().contains("febra"))
                panou.setText(panou.getText() + "\r\n" + " febra = nu");
            if(intrebare.getText().contains("este usoara"))
                panou.setText(panou.getText() + "\r\n" + " febra moderata = da");
            if(intrebare.getText().contains("frisoane"))
                panou.setText(panou.getText() + "\r\n" + " frisoane = nu");
            if(intrebare.getText().contains("musculare"))
                panou.setText(panou.getText() + "\r\n" + " dureri musculare = nu");
            if(intrebare.getText().contains("pofta de mancare"))
                panou.setText(panou.getText() + "\r\n" + " lipsa pofta de mancare = nu");
            if(intrebare.getText().contains("stare generala de rau"))
                panou.setText(panou.getText() + "\r\n" + " stare generala de rau = nu");
            if(intrebare.getText().contains("secretii nazale"))
                panou.setText(panou.getText() + "\r\n" + " secretii nazale = nu");
            if(intrebare.getText().contains("voma"))
                panou.setText(panou.getText() + "\r\n" + " voma = nu");
            if(intrebare.getText().contains("dureri de cap"))
                panou.setText(panou.getText() + "\r\n" + " dureri de cap = nu");
            if(intrebare.getText().contains("dureri in gat"))
                panou.setText(panou.getText() + "\r\n" + " dureri in gat = nu");
            if(intrebare.getText().contains("faringiene"))
                panou.setText(panou.getText() + "\r\n" + " inrosire mucoasa faringiana = nu");
            if(intrebare.getText().contains("inghitire"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la inghitire = nu");
            if(intrebare.getText().contains("olfactiv"))
                panou.setText(panou.getText() + "\r\n" + " perturbarea simtului olfactiv = nu");
            if(intrebare.getText().contains("uscaciune"))
                panou.setText(panou.getText() + "\r\n" + " senzatie de uscaciune in gat = nu");
            if(intrebare.getText().contains("ganglionilor"))
                panou.setText(panou.getText() + "\r\n" + " inflamare a ganglionilor = nu");
            if(intrebare.getText().contains("sufocati"))
                panou.setText(panou.getText() + "\r\n" + " sufocare = nu");
            if(intrebare.getText().contains("zgomotoasa"))
                panou.setText(panou.getText() + "\r\n" + " respiratie suieratoare, zgomotoasa = nu");
            if(intrebare.getText().contains("dificultate in respiratie"))
                panou.setText(panou.getText() + "\r\n" + " dificultate la respiratie = nu");
            if(intrebare.getText().contains("dureri in piept la respiratie"))
                panou.setText(panou.getText() + "\r\n" + " durere in piept in timpul respiratiei = nu");
            
            if(intrebare.getText().contains("Febra este usoara"))
            {
                da.setText("Da");
                nu.setText("Nu");
                aux.setVisible(false);
            }
            else if(intrebare.getText().contains("Febra este"))
            {
                da.setText("usoara");
                nu.setText("moderata");
                aux.setVisible(true);
                aux.setText("puternica");
            }
            else if(intrebare.getText().contains("tusei"))
            {
                da.setText("seaca");
                nu.setText("productiva");
            }
            
            primire_intrebari();
            returneaza_diagnostic();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void aux(java.awt.event.ActionEvent evt) 
    {
        setare_obiecte_start();
        try
        {
            clips.eval("(assert (raspuns nu2))");
            if(intrebare.getText().contains("este usoara"))
                panou.setText(panou.getText() + "\r\n" + " febra puternica = da");
                
            if(intrebare.getText().contains("Febra este usoara"))
            {
                da.setText("Da");
                nu.setText("Nu");
                aux.setVisible(false);
            }
            
            primire_intrebari();
            returneaza_diagnostic();
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
        }
    }
    
    public void primire_intrebari()
    {
        String intrebarea; //variabila in care se va salva intrebarea curenta
        try
        {
            clips.run();// fiecare program clips incepe cu apelarea run()      
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?x intrebare-curenta)) TRUE)");//interogare bc
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);//primire adresa faptelor interogate
            intrebarea = fact.getFactSlot("val").toString();//se preia slotul val din faptele returnate
            intrebare.setText(intrebarea);//se afiseaza intrebarea in label
        }
        catch(Exception ex){ex.printStackTrace();}
    }
        
    public void setare_obiecte_start()
    {
        auxiliar.setText(""); 
        auxiliar.setVisible(false);
        da.setVisible(true); 
        nu.setVisible(true); 
        aux.setVisible(false);
        panou.setVisible(true); 
        labelpanou.setVisible(true); 
        scroll.setVisible(true);
        da.setText("Da"); 
        nu.setText("Nu");
        restart.setVisible(false);
    }
    
    public void returneaza_diagnostic()
    {
        try
        {
            clips.run();           
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?x boala)) TRUE)"); // se cauta fapte cu numele boala
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);            
            String boala = fact.getFactSlot("denumire").toString(); // se preia informatia din slot-urile denumire si cf
            String coeficient = fact.getFactSlot("cf").toString();            
            String stop;
            stop = semnaleaza_oprire(); //se salveaza intr-o variabila raspunsul intors de functia semnaleaza_oprire
            if(stop.equals("da")) // daca raspunsul este da inseamna ca s-a semnalat oprirea interogarii pacientului
            {
                auxiliar.setVisible(true);
                auxiliar.setText("Rezultatul este: " + boala + " cu un procent de " + coeficient + "%");// se afiseaza diagnosticul
                ConexiuneDB.Diagnostic(boala, coeficient, user);//se introduce in baza de date diagnosticul
                restart.setText("Vezi mai multe");
                diag.setText(boala);
                recomandare.setText("procent " + coeficient + "%");
                restart.setBounds(230,290,140,30);
                restart.setVisible(true);
                da.setVisible(false);
                nu.setVisible(false);
                aux.setVisible(false);
            }
        }
        catch(Exception ex){}
    }
    
    public String semnaleaza_oprire()
    {
        String stop = "";
        try 
        {            
            clips.run();
            MultifieldValue mv = (MultifieldValue) clips.eval("(find-all-facts ((?y opreste)) TRUE)");// se cauta faptele cu numele opreste
            FactAddressValue fact = (FactAddressValue) mv.multifieldValue().get(0);
            stop = fact.getFactSlot("stop").toString();         
        } 
        catch (Exception ex) {}
        return stop;// intoarce textul gasit in slotul stop
    }
    
    private void Recomandari(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Asistent().setVisible(true);
    }
    
    private void Editare(java.awt.event.ActionEvent evt)
    {
        this.setVisible(false);
        new Profil().setVisible(true);
    }
}