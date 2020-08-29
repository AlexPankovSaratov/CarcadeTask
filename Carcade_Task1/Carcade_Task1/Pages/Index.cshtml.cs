using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Carcade_Task1.Model;
using Carcade_Task1.Servises;

namespace Carcade_Task1.Pages
{
    public class IndexModel : PageModel
    {
        public List<CustomerPayment> customerPayments;

        public IndexModel()
        {
        }
        public IEnumerable<CustomerPayment> GetRecords { get; set; }

        public async Task OnGet()
        {
        }
        public async Task OnPost(DateTime PaymentDate, string SubCustomerName)
        {
            PaymentServises paymentServises = new PaymentServises();
            customerPayments = paymentServises.GetAllCustomerPayment(SubCustomerName, PaymentDate);
        }
    }
}
