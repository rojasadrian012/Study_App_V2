const topicsController = require('../../controller/topics/topics.controller')


module.exports = function(app){
    app.get("/topics/list", topicsController.listar);
    app.get("/topics/buscarPorCodigo/:filtro", topicsController.busquedaPorCodigo);
    app.post("/topics/update", topicsController.actualizar);
    app.delete("/topics/delete/:filtro", topicsController.eliminar);
}