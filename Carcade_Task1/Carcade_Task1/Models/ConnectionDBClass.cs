using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Carcade_Task1.Model
{
    public class ConnectionDBClass : DbContext
    {
        public ConnectionDBClass(DbContextOptions<ConnectionDBClass> options) : base(options)
        {

        }
        public DbSet<CustomerPayment> Payments_T { get; set; } 
    }
}
