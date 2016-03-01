namespace StudentTimeOrganization
{
    using System;
    using System.Collections.Generic;
    using System.Globalization;
    using System.Linq;
    using System.Text;
    using System.Web;
    using System.Web.UI;
    using System.Web.UI.HtmlControls;
    using System.Web.ModelBinding;
    using System.Web.UI.WebControls;

    public partial class TaskView : Page
    {
        private const int AuthorId = 1;
        private const string personalName = "Boyana";
        private readonly ProjectStudentTimeOrganizationEntities context =
            new ProjectStudentTimeOrganizationEntities();

        private string taskAuthorOnSelection;
        private bool isTaskSelected;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Page.IsPostBack)
            {
                this.DropdownListPriority.DataSource = context.Priorities.ToList();
                this.DropdownListState.DataSource = context.States.ToList();
                this.DropdownListType.DataSource = context.Types.ToList();

                this.DataBind();

                ListViewNotes.Visible = false;
            }

            HtmlGenericControl js = new HtmlGenericControl("script");
            js.Attributes["type"] = "text/javascript";
            js.Attributes["src"] = "jscript/jquery.js";
            Page.Header.Controls.Add(js);

            HtmlLink css = new HtmlLink();
            css.Href = "/css/yourcss.css";
            css.Attributes["rel"] = "stylesheet";
            css.Attributes["type"] = "text/css";
            // css.Attributes["media"] = "all"; //add any attributes as needed
            Page.Header.Controls.Add(css);
        }

        protected void ButtonInsert_Click(object sender, EventArgs e)
        {
            // Create instance of task and insert it in table Tasks

            // Get values from user
            if (Page.IsValid)
            {
                var title = TextBoxTitle.Text;
                var content = TextBoxContent.Text;
                var priority = DropdownListPriority.SelectedValue;
                var state = DropdownListState.SelectedValue;
                int? type = null;
                if (DropdownListType.Text != string.Empty)
                {
                    type = int.Parse(DropdownListType.Text);
                }


                var dateAsString = TextBoxCalendar.Text;
                var inputTime = TextBoxTime.Text.Split(new char[] { ' ', ':' }, StringSplitOptions.RemoveEmptyEntries);
                StringBuilder time = new StringBuilder();
                time.Append(inputTime[0] + ':');
                time.Append(inputTime[1]);
                time.Append(' ' + inputTime[2]);
                dateAsString += ' ' + time.ToString();
                var date = DateTime.ParseExact(dateAsString, "MM/dd/yyyy hh:mm tt", CultureInfo.InvariantCulture);

                var location = string.Empty;
                if (TextBoxLocation.Text == String.Empty)
                {
                    location = null;
                }
                else
                {
                    location = TextBoxLocation.Text;
                }

                var noteText = TextBoxNote.Text;

                using (context)
                {
                    var task = new Task
                    {
                        Task_Title = title,
                        Task_Content = content,
                        Priority_ID = priority,
                        State_ID = int.Parse(state),
                        Type_ID = type,
                        Author_ID = AuthorId,
                        Creation_Date = DateTime.Now,
                        Date_Day = date,
                        Date_Time = date,
                        Location_Name = location,
                        Data_id = null
                    };

                    context.Tasks.Add(task);

                    if (noteText != "")
                    {
                        //var insertedTask = context.Tasks.Find(task);
                        var note = new Note
                        {
                            Note_Content = noteText,
                            Task_ID = task.Task_Id
                        };

                        context.Notes.Add(note);
                    }

                    context.SaveChanges();
                }

                LabelValidity.Text = "Task has been successfully added!";
            }
            else
            {
                LabelValidity.Text = "Task is invalid";
            }
        }

        // The return type can be changed to IEnumerable, however to support
        // paging and sorting, the following parameters must be added:
        //     int maximumRows
        //     int startRowIndex
        //     out int totalRowCount
        //     string sortByExpression
        public IQueryable<StudentTimeOrganization.Task> GridViewTask_GetData([Control] string DropDownListAuthorSearch)
        {
            var taskInformation = context.Tasks.OrderBy(t => t.Date_Time);

            //Search by one criteria, works only for model binding
            if (DropDownListAuthorSearch != null)
            {
                taskInformation = taskInformation.
                    Where(p => p.Author.Author_Name == DropDownListAuthorSearch).
                    OrderBy(t => t.Date_Time);
            }

            ListViewNotes.Visible = false;
            ListViewTaskDetails.Visible = false;
            return taskInformation;
        }


        //The id parameter name should match the DataKeyNames value set on the control
        public void GridViewTask_DeleteItem(int task_Id)
        {
            Response.Redirect("DeleteItem.aspx?task_Id=" + task_Id);
        }

        protected void GridViewTask_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (e.Row.Cells[6].Text != personalName)
                {
                    e.Row.Cells[1].Enabled = false;
                    var linkButtonDelete = (LinkButton)e.Row.FindControl("LinkButtonDelete");
                    linkButtonDelete.CssClass = "disabled";
                }
            }
        }

        protected void ListViewTaskDetails_ItemDataBound(object sender, ListViewItemEventArgs e)
        {
            LinkButton targetButton = (LinkButton)e.Item.FindControl("EditButton");
            var item = ListViewTaskDetails.Items;
            if (isTaskSelected)
            {
                if (taskAuthorOnSelection != null && taskAuthorOnSelection != personalName)
                {
                    targetButton.Visible = false;
                }

                isTaskSelected = false;
            }
        }

        protected void GridViewTask_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.ListViewTaskDetails.Visible = true;
            this.ListViewNotes.Visible = true;
            taskAuthorOnSelection = GridViewTask.SelectedRow.Cells[6].Text;
            isTaskSelected = true;
        }

        protected void ListViewTaskDetails_ItemUpdated(object sender, ListViewUpdatedEventArgs e)
        {
            this.GridViewTask.DataBind();
        }

        protected void GridViewTask_PageIndexChanged(object sender, EventArgs e)
        {
            ListViewTaskDetails.Visible = false;
            ListViewNotes.Visible = false;
        }

        protected void LinkButtonInsertNote_Click(object sender, EventArgs e)
        {
            //InsertItemPosition is already 'on' 
            this.ListViewNotes.InsertItemPosition = InsertItemPosition.LastItem;
        }

        protected void ListViewNotes_ItemInserted(object sender, ListViewInsertedEventArgs e)
        {
            this.ListViewNotes.InsertItemPosition = InsertItemPosition.None;
        }

        protected void ButtonCancel_Click(object sender, EventArgs e)
        {
            this.ListViewNotes.InsertItemPosition = InsertItemPosition.None;
        }

        protected void SynchronizeData_Click(object sender, EventArgs e)
        {
            using (context)
            {
                int insertedNews = context.Database.ExecuteSqlCommand(
                    "insert into News " +
"select post_title, post_description, getdate(), 3, id " +
"from v_site " +
"where id not in (select Data_id from Tasks where [Author_ID] = 4)");

                int insertedScheduleTasks = context.Database.ExecuteSqlCommand(
                  "insert into Tasks " +
"select post_title, post_description, 'H', 1, 3, 3, getdate(), schedule_date," + "schedule_date,post_location, id " +
"from v_schedule " +
"where id not in (select Data_id from Tasks where [Author_ID] = 3)");

                int insertedMoodleTasks = context.Database.ExecuteSqlCommand(
                  "insert into Tasks " +
"select post_title, post_description, 'H', 1, 2, 3, getdate(), moodle_date, moodle_date, null, id " +
"from v_moodle " +
"where id not in (select Data_id from Tasks where [Author_ID] = 2)");

                int totalInsertedTasks = insertedNews + insertedScheduleTasks + insertedMoodleTasks;

                this.GridViewTask.DataBind();

                InsertLabel.Text = string.Format("New {0} tasks available!", totalInsertedTasks);
            }
        }     

        //protected void ListViewNotes_ItemInserting(object sender, ListViewInsertEventArgs e)
        //{
        //    TextBox noteContentInsertControl = (TextBox)e.Item.FindControl("TextBoxNoteContent");
        //    string noteContent = noteContentInsertControl.Text;

        //    Label taskIdLabel = (Label)e.Item.FindControl("LabelTaskIDInsertTemplate");
        //    int taskId = int.Parse(taskIdLabel.Text);
        //}
    }
}