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
    
    public partial class Priority
    {
        public Priority()
        {
            this.Tasks = new HashSet<Task>();
        }
    
        public string Priority_Id { get; set; }
        public string Priority_Name { get; set; }
    
        public virtual ICollection<Task> Tasks { get; set; }
    }
}
