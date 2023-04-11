using Maderas.Datos;
using Maderas.Modelo;
using Microsoft.AspNetCore.Components.Forms;
using Microsoft.AspNetCore.Mvc;

namespace Maderas.Controllers
{
    [ApiController]
    [Route("api/proveedores")]
    public class ProveedorController
    {
        [HttpGet]
        public async Task <ActionResult<List<ModeloProveedor>>> Get()
        {
            var function = new DProveedores();


            var lista = await function.MostrarProveedores();

            return lista;
        }
        [HttpPost]
        public async Task Post([FromBody] ModeloProveedor parametros)
        {
            var function = new DProveedores();
            await function.InsertarProveedores(parametros);
        }
    }
}
