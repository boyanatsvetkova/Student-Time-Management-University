//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace StudentTimeOrganization
{
    using System;
    using System.Collections.Generic;
    
    public partial class Type
    {
        public Type()
        {
            this.Tasks = new HashSet<Task>();
        }
    
        public int Type_ID { get; set; }
        public string Type_Name { get; set; }
    
        public virtual ICollection<Task> Tasks { get; set; }
    }
}
