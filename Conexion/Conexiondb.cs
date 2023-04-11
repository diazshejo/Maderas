using Oracle.ManagedDataAccess.Client;
namespace Maderas.Conexion
{
    public class Conexiondb
    {
        private string ConnectionString = string.Empty;
        public Conexiondb() {
             var construc = new ConfigurationBuilder().SetBasePath
                  (Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json").Build();

             ConnectionString = construc.GetSection
                 ("ConnectionStrings:ConexionMaster").Value;
             OracleConnectionStringBuilder builder = new OracleConnectionStringBuilder();
           
             builder.ConnectionString = ConnectionString;
         }

        //OracleConnectionStringBuilder builder = new OracleConnectionStringBuilder();
      

        public string oradata()
        {

            return ConnectionString;
        }
    }
}
