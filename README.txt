Profil: Nivelul 1 - Server
Autor: BSD Management

Acest script execută teste pe sistem pentru a verifica conformitatea cu CIS Oracle Linux 7 Benchmarks.
Acest script nu aduce modificări fișierelor de sistem. 

Pentru a executa scriptul și obține probele este necesar să se urmeze următoarele etape:
	1. Scriptul este necesar de executat sub utilizatorul "root".
	2. Primul pas se atribuie drepturi de execuție scriptului, exemplu:
		# chmod +x Run_CIS_Oracle7_Scrypt.sh
	3. Executam scriptul:
		# ./Run_CIS_Oracle7_Scrypt.sh
	4. Asteptam finisarea execuției pină se va afișa mesajul "Finish! THX!".
	5. După finisarea execuției, în folderul părinte al scriptului va fi creată automat o arhivă cu denumirea "Oracle_Linux_Audit_Evidence.tar", necesară de copiat și de expediat către BSD. În caz că arhiva nu va fi creată, către BSD se vor arhiva manual  folderul "./result" și fișierul generat automat in folderul părint al scriptului, cu denumirea "Resume{date}.txt".
	
