namespace StudentTimeOrganization
{
    using System;
    using System.Collections.Generic;
    using System.Data;
    using System.Data.Entity.Infrastructure;
    using System.Linq;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.WebControls;

    public partial class DeleteItem : System.Web.UI.Page
    {
        private int taskId;
        private readonly ProjectStudentTimeOrganizationEntities context = new ProjectStudentTimeOrganizationEntities();
        protected void Page_Load(object sender, EventArgs e)
        {
            var idAsString = Request.QueryString["task_Id"];
            taskId = int.Parse(idAsString);
        }

        protected void ButtonYes_Click(object sender, EventArgs e)
        {
            using (context)
            {
                var item = context.Tasks.Find(taskId);

                if (item == null)
                {
                    LabelAlertMessage.Text = "Task has been already deleted!";
                    return;
                }

                context.Entry(item).State = EntityState.Deleted;
                try
                {
                    context.SaveChanges();
                    LabelAlertMessage.Text = "Task has been deleted successfully!";
                }
                catch (DbUpdateConcurrencyException)
                {
                    ModelState.AddModelError("",
                      String.Format("Item with id {0} no longer exists in the database.", taskId));
                }
            }
        }

        protected void ButtonNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("TaskView.aspx");
        }
    }
}