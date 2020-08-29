using Carcade_Task1.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Carcade_Task1.IServises
{
    public interface IPaymentServises
    {
        List<CustomerPayment> GetAllCustomerPayment(string SubCustomerName, DateTime PaymentDate);
    }
}
