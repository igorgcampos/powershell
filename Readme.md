-> Problema : Maquina virtual que necessita de muitas vlans e pelo GUI do Hyper-V nao estava deixando criar mais de 8 interfaces.
-> Solução :
   1 -  Criar as interfaces pelo powershell;
   2 -  Colocar a id da vlan na interface criada;
   3 -  Pegar o mac address de todas as interfaces que foram criadas na vm;
   4 -  "Bater" o macaddress com a interface virtual dentro da VM;
   5 -  Colocar IP na interface certa.
