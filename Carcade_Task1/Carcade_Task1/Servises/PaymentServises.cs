using Carcade_Task1.Common;
using Carcade_Task1.IServises;
using Carcade_Task1.Model;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace Carcade_Task1.Servises
{
    public class PaymentServises : IPaymentServises
    {
        List<CustomerPayment> _customerPayments = new List<CustomerPayment>();
        public List<CustomerPayment> GetAllCustomerPayment(string SubCustomerName, DateTime PaymentDate)
        {
            _customerPayments = new List<CustomerPayment>();
            using (IDbConnection con = new SqlConnection(Global.ConnectionString))
            {
                SqlCommand cmd = (SqlCommand)con.CreateCommand();
                if (con.State == ConnectionState.Closed) con.Open();
                cmd.CommandText = "dbo.GetСounterPayments";
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                var SubCustomerNameParam = new SqlParameter()
                {
                    DbType = System.Data.DbType.String,
                    ParameterName = "@SubCustomerName",
                    Value = SubCustomerName,
                };
                var PaymentDateParam = new SqlParameter()
                {
                    DbType = System.Data.DbType.DateTime2,
                    ParameterName = "@PaymentDate",
                    Value = PaymentDate,
                };
                cmd.Parameters.Add(SubCustomerNameParam);
                cmd.Parameters.Add(PaymentDateParam);
                SqlDataReader sqlDataReader = cmd.ExecuteReader();
                while (sqlDataReader.Read())
                {
                    int CustomerId = (int)sqlDataReader["CustomerId"];
                    string CustomerName = (string)sqlDataReader["CustomerName"];
                    decimal Sum = (decimal)sqlDataReader["Sum"];
                    DateTime PayDate = (DateTime)sqlDataReader["PaymentDate"];
                    _customerPayments.Add(new CustomerPayment(CustomerId, CustomerName, Sum, PaymentDate));
                }
            }
            return _customerPayments;
        }
    }
}
