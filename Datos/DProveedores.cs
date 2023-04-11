using Maderas.Conexion;
using Maderas.Modelo;
using Oracle.ManagedDataAccess.Client;
using System.Data;

namespace Maderas.Datos
{
    public class DProveedores
    {
        private const string CmdText = "obtener_proveedores";
        private const string CmdIns = "SP_INS_Proveedor";
        Conexiondb cn = new Conexiondb();
        public async Task<List<ModeloProveedor>> MostrarProveedores()
        {
            var lista = new List<ModeloProveedor>();

            using (OracleConnection connectdb = new OracleConnection(cn.oradata()))
            {
                //connectdb.Open();
                OracleCommand command = new(CmdText, connectdb);

                await connectdb.OpenAsync();

                command.CommandType = CommandType.StoredProcedure;

                // crea un parámetro para el cursor de salida
                OracleParameter cursorParam = command.Parameters.Add("p_cursor", OracleDbType.RefCursor);
               
                cursorParam.Direction = ParameterDirection.Output;

                using (var item = await command.ExecuteReaderAsync())
                {
                    while (await item.ReadAsync())
                    {
                        var ModeloProveedor = new ModeloProveedor();

                        ModeloProveedor.ID_PROVEEDOR = Convert.ToInt32(item["ID_PROVEEDOR"]);
                        ModeloProveedor.NOMBRE = (string)item["NOMBRE"];
                        ModeloProveedor.NIT = (string)item["NIT"];
                        ModeloProveedor.TELEFONO = (string)item["TELEFONO"];
                        ModeloProveedor.CORREO_ELECTRONICO = (string)item["CORREO_ELECTRONICO"];

                        lista.Add(ModeloProveedor);


                    }
                }



            }
            return lista; //retorno la lista de los datos desde sp
        }

        public async Task InsertarProveedores(ModeloProveedor parametros)
        {

            using (OracleConnection connectdb = new OracleConnection(cn.oradata()))
            {

                OracleCommand command = new(CmdIns, connectdb);

                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.Add("Vcod_proveedor", parametros.ID_PROVEEDOR);
                command.Parameters.Add("Vnombre", parametros.NOMBRE);
                command.Parameters.Add("Vnit", parametros.NIT);
                command.Parameters.Add("Vtelefono", parametros.TELEFONO);
                command.Parameters.Add("Vemail", parametros.CORREO_ELECTRONICO);
                await connectdb.OpenAsync();

                await command.ExecuteReaderAsync();
            }
        }
    }
}
