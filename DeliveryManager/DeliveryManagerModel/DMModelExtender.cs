using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DeliveryManager.Orders;

namespace DeliveryManager.DeliveryManagerModel
{
    public partial class FullName
    {
        public string Combined
        {
            get
            {
                return string.IsNullOrWhiteSpace(this.MiddleName)
                    ? string.Format("{0} {1}", this.Name, this.Surname)
                    : string.Format("{0} {1} {2}", this.Name, this.MiddleName, this.Surname);
            }
        }
    }

    public partial class User
    {
        public string CombinedName
        {
            get
            {
                return this.FullName.Combined;
            }
        }
    }

    public partial class Entry
    {
        partial void OnCountChanging(int value)
        {
            /* Initial state - Something is bought
             * this.Count = 0, value = 1 => diff = -1
             * DepotEntry.Count - 1
 
             * Increasing entry's count, decresing DepotEntry's
             * this.Count = 1, value = 2 => diff = -1
             * DepotEntry.Count - 1

             * Decreasing entry's count, incresing DepotEntry's
             * this.Count = 2, value = 1 => diff = 1
             * DepotEntry.Count + 1

             * Nothing changed
             * this.Count = 1, value = 1 => diff = 0
             * DepotEntry.Count + 0
             */
            var diff = this.Count - value;
            if (this is OrderEntry)
            {
                var orderEntry = this as OrderEntry;
                if (orderEntry.DepotEntry != null)
                    orderEntry.DepotEntry.Count += diff;
            }
            else if (this is CorrectionEntry)
            {
                var correctionEntry = this as CorrectionEntry;
                if (correctionEntry.DepotEntry != null)
                {
                    if (correctionEntry.Correction.CorrectionType.IsNegative)
                        correctionEntry.DepotEntry.Count += diff;
                    else
                        correctionEntry.DepotEntry.Count -= diff;
                }
            }
        }
    }

    public partial class Order
    {
        public decimal TotalPrice
        {
            get
            {
                decimal totalPrice = 0;
                foreach (var orderEntry in this.OrderEntries)
                {
                    totalPrice += orderEntry.Price * orderEntry.Count;
                }
                return totalPrice;
            }
        }

        public string IncludedInDelivery
        {
            get
            {
                return this.Delivery != null ? "Yes" : "No";
            }
        }

        /// <summary>
        /// Intended for file operations
        /// </summary>
        public string SafeNumber
        {
            get
            {
                return this.Number.Replace(OrderConstants.SPbNumberAbbr, OrderConstants.SafeSPbNumberAbbr);
            }
        }
    }

    public partial class Delivery
    {
        public decimal TotalPrice
        {
            get
            {
                var totalPrice = this.DeliveryType.Cost;
                foreach (var order in this.Orders)
                {
                    totalPrice += order.TotalPrice;
                }
                return totalPrice;
            }
        }

        public string OrderNumbers
        {
            get
            {
                return this.Orders.Any()
                    ? this.Orders.Select(o => o.Number).Aggregate((workingSentence, next) => workingSentence + ", " + next)
                    : String.Empty;
            }
        }

        /// <summary>
        /// Intended for file operations
        /// </summary>
        public string SafeOrderNumbers
        {
            get
            {
                return this.Orders.Any()
                    ? this.Orders.Select(o => o.SafeNumber).Aggregate((workingSentence, next) => workingSentence + "_" + next)
                    : String.Empty;
            }
        }
    }

    public partial class Depot
    {
        public decimal TotalCost
        {
            get
            {
                decimal totalCost = 0;
                foreach (var entry in this.DepotEntries)
                {
                    totalCost += entry.DeliveryEntity.Cost * entry.Count;
                }
                return totalCost;
            }
        }

        public decimal TotalPrice
        {
            get
            {
                decimal totalPrice = 0;
                foreach (var entry in this.DepotEntries)
                {
                    totalPrice += entry.DeliveryEntity.Price * entry.Count;
                }
                return totalPrice;
            }
        }
    }

    public partial class DeliveryEntity
    {
        public string EntityType
        {
            get { return this is Book ? "Book" : "CD"; }
        }
    }

    public partial class Correction
    {
        public decimal TotalCost
        {
            get
            {
                decimal totalCost = 0;
                foreach (var entry in this.CorrectionEntries)
                {
                    totalCost += entry.Cost * entry.Count;
                }
                return totalCost;
            }
        }
    }
}