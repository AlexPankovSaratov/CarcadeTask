using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Carcade_Task1.Model
{
    public class CustomerPayment
    {
        private int _customerId;
        private string _customerName;
        private decimal _sum;
        private DateTime _paymentDate;

        public int CustomerId
        {
            get { return _customerId; }
        }
        public string CustomerName
        {
            get { return _customerName; }
        }
        public decimal Sum
        {
            get { return _sum; }
        }
        public DateTime dateTime
        {
            get { return _paymentDate; }
        }     

        public CustomerPayment(int CustomerId, string CustomerName, decimal Sum, DateTime dateTime)
        {
            _customerId = CustomerId;
            _customerName = CustomerName;
            _sum = Sum;
            _paymentDate = dateTime;
        }
    }
}
