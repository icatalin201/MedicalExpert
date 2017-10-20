package MedicalExpert;

import java.awt.Color;
import java.awt.Font;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPasswordField;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import net.proteanit.sql.DbUtils;

/**
 *
 * @author Catalin
 */
public class ConexiuneDB
{
    static Connection conn;
    public static Connection Conexiune() throws ClassNotFoundException
    {
        Connection conex = null;//se initializeaza variabila conex
        try 
        {
            String dbuser = "root"; // nume utilizator baza de date
            String dbpass = ""; // parola baza de date
            String dbName = "medicalexpert"; // numele bazei de date
            String aux = "?autoReconnect=true&useSSL=false"; // instructiune pentru reconectare
            String url = "jdbc:mysql://localhost/" + dbName + aux; // link-ul de conectare
            Class.forName("com.mysql.jdbc.Driver"); // incarcare driver mysql connector
            conex = DriverManager.getConnection(url, dbuser, dbpass); // se stabileste conexiunea
        } 
        catch (SQLException ex) 
        {
            //se returneaza mesaj daca conectarea a esuat
            JOptionPane.showMessageDialog(null,"Conectare la baza de date esuata!");
        }
        return conex; // se intoarce variabila de tip conexiune
    }  
    public static void Logare(JTextField user, JPasswordField pass) throws ClassNotFoundException
    {
        try
        {    
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();//se interogheaza baza de date
            ResultSet res = st.executeQuery("SELECT * FROM utilizatori WHERE user='" + user.getText()+"' AND parola=md5('" + pass.getText()+"')");
            if(res.next()) // daca sunt gasite  rezultate
            {
                new MesajLogin().setVisible(true); //afiseaza mesaj
            } 
            else // altfel  afiseaza mesaj de eroare
            {
                JOptionPane.showMessageDialog(null, "Verifica datele introduse!");
                user.setForeground(Color.GRAY);
                user.setText("nume utilizator");
                user.setFont(new Font("Monaco", Font.ITALIC, 16));
                pass.setForeground(Color.GRAY);
                pass.setText("parola");
                pass.setFont(new Font("Monaco", Font.ITALIC, 16));
                
            }
            conn.close();//se inchide conexiunea
	} 
        catch(SQLException e) {}
    }
    public static void Inregistrare(JTextField user, JPasswordField pass, JTextField fname, JTextField lname, JTextField age, String sex) throws ClassNotFoundException
    {
        try 
        {
            conn = Conexiune();//se stabileste conexiunea    
            if((user.getText().isEmpty()) || (pass.getText().isEmpty()) || (fname.getText().isEmpty()) || (lname.getText().isEmpty()) || (age.getText().isEmpty()))
            {
                new Info().setVisible(true); //daca sunt campuri goale se afiseaza mesaj
            }
            
            else 
            {
                if(age.getText().matches("[0-9]+"))//se verifica daca datele din campul varsta sunt numerice
                {
                    Statement stat = conn.createStatement();
                    ResultSet rs = stat.executeQuery("SELECT user FROM utilizatori");//se interogheaza baza de date
                    if(rs.next())
                    {
                        if(rs.getString("user").matches(user.getText()))//se verifica existenta numelui de utilizator
                        {
                            JOptionPane.showMessageDialog(null, "Acest nume de utilizator exista deja!");
                        }
                        else
                        {
                            Statement st = conn.createStatement();
                            st.executeUpdate("INSERT INTO utilizatori(nume, prenume, varsta, sex, user, parola)" + 
                            "VALUES ('" + fname.getText() + "','" + lname.getText() + "','" + age.getText() + "','" + sex + "','" +
                                user.getText() + "'," + "md5(" + "'" + pass.getText() + "'))");
                            new MesajReg().setVisible(true);//se introduc datele in baza de date
                        }
                    }
                    else{
                        Statement st = conn.createStatement();
                        st.executeUpdate("INSERT INTO utilizatori(nume, prenume, varsta, sex, user, parola)" + 
                        "VALUES ('" + fname.getText() + "','" + lname.getText() + "','" + age.getText() + "','" + sex + "','" +
                        user.getText() + "'," + "md5(" + "'" + pass.getText() + "'))");
                        new MesajReg().setVisible(true);//se introduc datele in baza de date
                    }
                }
                else if((age.getText().matches("[a-z]+")) || (age.getText().matches("[A-Z]+")))//daca campul varsta nu contine doar cifre
                {
                    JOptionPane.showMessageDialog(null, "Campul varsta poate contine doar cifre!");
                }
            }
            conn.close();//se inchide conexiunea
        } 
        catch (SQLException ex){System.out.println(ex);}
    }
    public static void UserName(JTextField user, JLabel nume) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();
            ResultSet res = st.executeQuery("SELECT prenume FROM utilizatori WHERE user='" + user.getText() + "'");//se interogheaza baza de date
            while(res.next())//daca sunt rezultate
            {
                nume.setText("Bun venit, " + res.getString("prenume") + "!");//se afiseaza prenumele
            }
            conn.close();//se inchide conexiunea
        }
        catch(SQLException ex){}
    }
    public static void UserNameLateral(JTextField user, JLabel nume) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();
            Statement st = conn.createStatement();
            ResultSet res = st.executeQuery("SELECT prenume, nume FROM utilizatori WHERE user='" + user.getText() + "'");
            while(res.next())
            {
                nume.setText(res.getString("prenume") + " " + res.getString("nume"));
                nume.setFont(new Font("Monaco",Font.BOLD,14));
            }
            conn.close();
        }
        catch(SQLException ex){}
    }
    public static void Diagnostic_curent(JTextField user, JLabel label, JLabel label2) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();
            Statement stat = conn.createStatement();
            ResultSet rs = stat.executeQuery("SELECT id FROM utilizatori WHERE user='" + user.getText() +  "'");
            
            while(rs.next())
            {
                int ID = Integer.parseInt(rs.getString("id"));
                Statement st = conn.createStatement();
                ResultSet res = st.executeQuery("SELECT diagnostic_curent, procent_diagnostic FROM diagnostic_curent WHERE id="+ ID + "");
                
                if(res.next())
                {
                    label.setText(res.getString("diagnostic_curent"));
                    label.setFont(new Font("Monaco",Font.BOLD,14));
                    label2.setText("procent " + res.getString("procent_diagnostic") + "%");
                    label2.setFont(new Font("Monaco",Font.BOLD,14));
                }
                else
                {
                    label.setText("diagnostic inexistent");
                    label.setFont(new Font("Monaco",Font.BOLD,14));
                }
            }
            conn.close();
        }
        catch(SQLException ex){}
    }
    public static void Diagnostic(String boala, String cf, JTextField user) throws ClassNotFoundException
    {
        try
        {
            int ID;
            int procent = Integer.parseInt(cf);//se converteste variabila string preluata din parametrii la int
            DateFormat format_data = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");//format data
            Calendar data_curenta  = Calendar.getInstance();//definire variabila de tip calendar
            String data = format_data.format(data_curenta.getTime());//se preia data curenta
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();
            ResultSet res = st.executeQuery("SELECT id FROM utilizatori WHERE user='" + user.getText() +  "'");

            if(res.next())
            {                                                     
                ID = Integer.parseInt(res.getString("id"));//id-ul utilizatorului curent
                
                Statement curent = conn.createStatement();
                ResultSet set = curent.executeQuery("SELECT data_diagnostic, diagnostic_curent, procent_diagnostic, id FROM diagnostic_curent WHERE id=" + ID + "");
                
                if(set.next()) // exista inregistrari in diagnostic curent cu id curent
                {
                    int id_curent = Integer.parseInt(set.getString("id"));//se preiau datele din tabela
                    String diagnostic = set.getString("diagnostic_curent");
                    String data_diagnostic = set.getString("data_diagnostic");
                    int procent_diagnostic = set.getInt("procent_diagnostic");
                    //se introduc datele in tabela istoric
                    curent.executeUpdate("INSERT INTO istoric_diagnostic(data_diagnostic, diagnostic_anterior, procent_diagnostic, id)"
                                + "VALUES ('" + data_diagnostic + "','" + diagnostic + "'," + procent_diagnostic + "," + id_curent + ")");
                        
                    Statement introducere = conn.createStatement();//se actualizeaza tabela diagnostic curent cu noul diagnostic
                    introducere.executeUpdate("UPDATE diagnostic_curent SET data_diagnostic='"+data+"', diagnostic_curent='"+boala+"', procent_diagnostic="+ procent +", id="+ ID + " WHERE id=" + ID + "");               
                }
                
                else //nu exista inregistrari in diagnostic curent cu id curent
                {
                    Statement introducere = conn.createStatement();
                    introducere.executeUpdate("INSERT INTO diagnostic_curent(data_diagnostic,diagnostic_curent, procent_diagnostic, id)"
                            + "VALUES ('" + data + "','" + boala + "'," + procent + "," + ID + ")");
                }
            }
            conn.close();//se inchide conexiunea
        }
        catch(SQLException ex){
        System.out.println(ex);}
    }
    public static void istoric (JTable tabel, JTextField user) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();//se preia id-ul utilizatorului curent
            ResultSet res = st.executeQuery("SELECT id FROM utilizatori WHERE user='" + user.getText() +  "'");
            while(res.next())
            {                                                     
                int id = Integer.parseInt(res.getString("id"));
                
                Statement istoric = conn.createStatement();
                ResultSet rs = istoric.executeQuery("SELECT id_diagnostic, data_diagnostic, diagnostic_anterior, procent_diagnostic FROM istoric_diagnostic WHERE id=" + id + " ORDER BY id_diagnostic DESC");
                tabel.setModel(DbUtils.resultSetToTableModel(rs));//se afiseaza in tabel istoricul pt userul cu ID gasit
            }
            conn.close();//se inchide conexiunea
        }
        catch(SQLException ex)
        {
            System.out.println(ex);
        } 
    }
    public static void actual(JLabel label, JTextField user) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();//se cauta id-ul si prenumele user-ului
            ResultSet res = st.executeQuery("SELECT id, prenume FROM utilizatori WHERE user='" + user.getText() +  "'");
            while(res.next())
            {
                String username = res.getString("prenume");//se preiau informatiile
                int id = res.getInt("id");
                Statement stat = conn.createStatement();//se cauta informatiile despre user
                ResultSet rs = stat.executeQuery("SELECT diagnostic_curent, procent_diagnostic FROM diagnostic_curent WHERE id="+ id + "");
                
                if(rs.next())//daca exista date
                {
                    String diag = rs.getString("diagnostic_curent");//se preiau datele 
                    int pondere = rs.getInt("procent_diagnostic");//si se afiseaza in label
                    label.setText("<html><p align=center>" + username + ", <br><br> diagnosticul tau curent conform ultimului test este"
                            + "<br><br>" + diag + " cu un procent de " + pondere + "%.</p></html>");
                }
                else//daca nu sunt date se afiseaza mesaj
                {
                    label.setText("<html><p align=center>" + username + ", se pare ca nu ai efectuat niciun test de diagnosticare."
                            + "<br></p></html>");
                }
            }
            conn.close();//se inchide conexiunea
        }
        catch(SQLException ex)
        {
            System.out.println(ex);
        }
    }
    public static void recomandari(JLabel boala, JLabel info1, JTextArea info2, JTextArea info3) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();//se stabileste conexiunea
            Statement st = conn.createStatement();//se preiau  datele despre  boala gasita
            ResultSet rs = st.executeQuery("SELECT * FROM boli WHERE denumire='" + boala.getText() + "'");
            while(rs.next())
            {
                String denumire = rs.getString("denumire");
                String despre = rs.getString("despre");
                String recomandari = rs.getString("recomandari");
                
                info1.setText(denumire);//se afiseaza datele despre boala gasita
                info2.setText(despre);
                info3.setText(recomandari);
                info2.setCaretPosition(0);
                info3.setCaretPosition(0);
            }
            conn.close();//se inchide conexiunea
        }
        catch(SQLException ex){System.out.println(ex);}
    }
    public static void info_editare(JLabel nume, JTextField username, JTextField varsta, JTextField user_curent) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM utilizatori WHERE user='"+user_curent.getText()+"'");
            if(rs.next())
            {
                nume.setText(rs.getString("nume") + " " + rs.getString("prenume"));
                username.setText(rs.getString("user"));
                varsta.setText(rs.getString("varsta"));
            }
            conn.close();
        }
        catch(SQLException ex){}
    }
    public static void editare(JTextField username, JPasswordField parola, JTextField varsta, JTextField user_curent) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM utilizatori WHERE user='"+user_curent.getText()+"'");
            if(rs.next())
            {
                int id = rs.getInt("id");
                if(varsta.getText().matches("[0-9]+"))
                {
                    Statement stat = conn.createStatement();
                    stat.executeUpdate("UPDATE utilizatori SET user='"+username.getText()+"',parola=md5('"+parola.getText()+"'),varsta="+varsta.getText()+" WHERE id="+ id +"");
                }
                else if((varsta.getText().matches("[a-z]+")) || (varsta.getText().matches("[A-Z]+")))
                {
                    JOptionPane.showMessageDialog(null, "Campul varsta poate contine doar cifre!");
                }
            }
            conn.close();
        }
        catch(SQLException ex){}
    }
    public static void notificare(Buton buton, JLabel label, JTextField user) throws ClassNotFoundException
    {
        try
        {
            conn = Conexiune();
            Statement st = conn.createStatement();
            
            DateFormat data_ct = new SimpleDateFormat("dd");
            Calendar zi_calendar = Calendar.getInstance();
            int zi_curenta = Integer.parseInt(data_ct.format(zi_calendar.getTime()));
            ResultSet res = st.executeQuery("SELECT id, prenume FROM utilizatori WHERE user='" + user.getText() +  "'");
            while(res.next())
            {                                                     
                int id = Integer.parseInt(res.getString("id"));
                Statement stat = conn.createStatement();
                ResultSet rs = stat.executeQuery("SELECT data_diagnostic FROM diagnostic_curent WHERE id=" + id +  "");
                if(rs.next())
                {
                    String data = rs.getString("data_diagnostic");
                    int zi_diag = Integer.parseInt(data.substring(8,10));
                    int dif = zi_curenta -  zi_diag;
                    if(dif >= 1)
                    {
                        label.setVisible(true);
                        buton.setVisible(true);
                        String afis = Integer.toString(dif);
                        label.setText("<html><p align=center>Au trecut " + afis 
                                + " zile de la ultimul test.<br><br>"
                                        + "Poti sa refaci testul pentru a iti verifica starea actuala.<br><br><br>"
                                        + "*vei fi redirectionat catre modulul corespunzator afectiunii tale. </p></html>");
                    }
                    else
                    {
                        label.setVisible(false);
                        buton.setVisible(false);
                    }
                }
            }
            conn.close();
        }
        catch(SQLException ex) {System.out.println(ex);}
    }
}