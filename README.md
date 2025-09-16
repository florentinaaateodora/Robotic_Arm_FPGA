Proiectul a urmărit realizarea unui prototip de braț robotic controlat cu ajutorul unei platforme FPGA, având ca obiectiv implementarea unui sistem de manipulare a obiectelor ușoare, în condiții de control precis și stabilitate ridicată. O astfel de soluție poate fi utilizată în aplicații unde manipularea directă a anumitor obiecte poate implica riscuri pentru operator.

Pentru dezvoltarea sistemului au fost studiate principiile de funcționare ale brațelor robotice, mecanismele de acționare cu servomotoare și metodele de generare a semnalelor PWM necesare poziționării precise a acestora. De asemenea, au fost analizate avantajele oferite de utilizarea platformelor FPGA în controlul sistemelor robotice, datorită flexibilității și capacității de procesare în timp real.

Implementarea a fost realizată pe placa de dezvoltare Pynq-Z2, utilizând mediul de programare Xilinx Vivado. Au fost proiectate și implementate module hardware în limbaj VHDL pentru generarea semnalelor PWM, selecția motorului activ în funcție de poziția switch-urilor, precum și pentru controlul incremental al poziției fiecărei articulații, prin acționarea butoanelor.

După integrarea sistemului hardware, au fost efectuate teste practice care au confirmat stabilitatea și precizia funcționării. Brațul robotic a reușit să manipuleze obiecte de până la 10 grame, executând mișcările comandate într-un mod stabil și controlat. S-a demonstrat astfel că prin utilizarea platformelor FPGA se pot obține soluții eficiente și fiabile pentru controlul sistemelor robotice.

Rezultatele obținute validează funcționalitatea arhitecturii propuse și evidențiază potențialul extinderii sistemului către aplicații mai complexe, în care precizia, stabilitatea și siguranța operării reprezintă cerințe esențiale.


[Braț artificial pentru manipularea obiectelor explozibile.pptx](https://github.com/user-attachments/files/22363913/Bra.artificial.pentru.manipularea.obiectelor.explozibile.pptx)
