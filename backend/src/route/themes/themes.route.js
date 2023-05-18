const themesController = require('../../controller/themes/themes.controller')
//require es como un import para referenciar archivos

module.exports = function(app){
    app.get("/themes/list", themesController.listar);
    app.get("/themes/buscarPorCodigo/:filtro", themesController.busquedaPorCodigo);
    app.post("/themes/update", themesController.actualizar);
    app.delete("/themes/delete/:filtro", themesController.eliminar);
}