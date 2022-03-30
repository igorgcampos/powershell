> Problema : Maquina virtual que necessita de muitas vlans e pelo GUI do Hyper-V nao estava deixando criar mais de 8 interfaces.
> Solução : Criar as interfaces pelo powershell,colocar a id da vlan na interface criada,pegar o mac address de todas as interfaces que foram criadas na vm,
"bater" o macaddress com a interface virtual dentro da VM, colocar IP na interface certa.
