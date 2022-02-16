<?php
    include_once 'conexao.php';

    $SQL = "SELECT A.nome,
                   A.id,
                   A.marca,
                   A.valor,
                   A.estoque,
                   A.valorestoque,
                   B.nome AS criador_nome
              FROM produto A
            INNER JOIN usuarios B ON B.ID = A.CRIADOR";

    function pre_r($array){
        echo '<pre>';
        print_r($array);
        echo '</pre>';
    }
    try{
        
        $Query = $conn->prepare($SQL);
        $Query->execute();
        //$Query = $Query->fetch(PDO::FETCH_ASSOC);
        ?>
        <center>
        <table class="textbox" >
            <thead>
                <tr class="tabela">
                    <th>Nome</th>
                    <th>Marca</th>
                    <th>Valor</th>
                    <th>Estoque</th>
                    <th>Valor em estoque</th>
                    <th>Criador</th>
                    <th>Ação</th>
                </tr>
            </thead> 
            <?php
                while ($row = $Query->fetch(PDO::FETCH_ASSOC)):?>   
                    <tr>
                        <td><?php echo $row['nome'];?></td>
                        <td><?php echo $row['marca'];?></td>
                        <td><?php echo $row['valor'];?></td>
                        <td><?php echo $row['estoque'];?></td>
                        <td><?php echo $row['valorestoque'];?></td>
                        <td><?php echo $row['criador_nome'];?></td>
                        <td> 
                            <button class="editar" name="update"><a href="sistema.php?update=true&edit=<?php echo $row['id']; ?>">Editar</a>
                            <button class="deletar" name="delete"><a href="processar.php?delete=<?php echo $row['id']; ?>">Deletar</a></button>
                        </td>
                    </tr>
                <?php endwhile; ?>
        </table>
        </center>
    <?php
    }catch(PDOException $erro){
        $_SESSION['MsgErro'] = "Erro: Não foi possível buscar os registros. Erro gerado " . $erro->getMessage();
    }
?>