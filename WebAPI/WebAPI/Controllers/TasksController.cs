using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebAPI.Models;
using WebAPI.Domain;

namespace WebAPI.Controllers
{
    public class TasksController : ApiController
    {
        List<TaskModel> tt = new List<TaskModel>();

        // GET api/tasks
        [HttpGet]
        public IEnumerable<TaskModel> Get()
        {
         
            //Many, many better ways to do this but just to keep it simple I am getting the data straight from the EF
            Test testContext = new Test();
            List<Task> listOfTasks = testContext.Tasks.Where( x => x.TaskIsCompleted == false && x.TaskIsDiscarded == false).ToList();

            //and doing the mapping here.
            foreach (Task aTask in listOfTasks)
            {
                addTaskToTaskModels(aTask, tt);
            }

            return tt;
        }

        /// <summary>
        /// addTaskToTaskModels, this method is replacement for a mapping class just for simplicity sake
        /// </summary>
        /// <param name="dbTask"></param>
        /// <param name="listUITaskModels"></param>
        private void addTaskToTaskModels(Task dbTask, List<TaskModel> listUITaskModels)
        {
            TaskModel uiModelTask = new TaskModel() { UserId =dbTask.UserId, TaskDescription =dbTask.TaskDescription,
                            CompletedDate =dbTask.CompletedDate, CreatedDate =dbTask.CreatedDate,
                            TaskIsCompleted =dbTask.TaskIsCompleted, TaskIsDiscarded =dbTask.TaskIsDiscarded
            };
            listUITaskModels.Add(uiModelTask);

        }

       
        // POST api/Task
        [HttpPost]
        public void Post(TaskModel value)
        {
            //Nothing to do if there is nothing there
            if (value == null)
            {
                return;
            }   
            
            //Map the UI model to the db model
            Task theNewTask = new Task() { TaskDescription = value.TaskDescription, TaskIsCompleted = value.TaskIsCompleted,
                CreatedDate = DateTime.Now, TaskIsDiscarded = false, TaskName = value.TaskDescription, UserId = value.UserId };

            //Many, many better ways to do this but just to keep it simple I am getting the data 
            Test testContext = new Test();
            testContext.Tasks.Add(theNewTask);
            testContext.SaveChanges();

            return;
        }

        [HttpPut]
        public void Put(TaskModel value)
        {
            //Nothing to do if there is nothing there
            if (value == null)
            {
                return;
            }

            Test testContext = new Test();

            //var completedTaskList = testContext.Tasks.Where(x => x.TaskId == taskId).ToList();
            var taskList = testContext.Tasks.Where(x => x.TaskName.ToLower() == value.TaskName.ToLower()).ToList();

            if (taskList.Count < 1)
            {
                return;
            }

            //Get the tasks
            Task updateTask = taskList.SingleOrDefault();
            
            //Map the UI model to the db model
            updateTask.TaskDescription = (value.TaskDescription != null) ? value.TaskDescription : updateTask.TaskDescription;
            updateTask.TaskIsCompleted = (value.TaskIsCompleted != null) ? value.TaskIsCompleted : updateTask.TaskIsCompleted;
            updateTask.TaskIsDiscarded = (value.TaskIsDiscarded != null) ? value.TaskIsDiscarded : updateTask.TaskIsDiscarded;

            //Many, many better ways to do this but just to keep it simple I am getting the data 
            testContext.SaveChanges();

            return;
        }


        private void ToggleCompleted(string taskName)
        {
            //int taskId = int.Parse(Id);
            if (string.IsNullOrWhiteSpace(taskName))
            {
                return;
            }
            
            //Many, many better ways to do this but just to keep it simple I am getting the data 
            Test testContext = new Test();
            
            //var completedTaskList = testContext.Tasks.Where(x => x.TaskId == taskId).ToList();
            var completedTaskList = testContext.Tasks.Where(x => x.TaskName.ToLower() == taskName.ToLower()).ToList();

            if(completedTaskList.Count < 1)
            {
                return;
            }

            Task completedTask = completedTaskList.SingleOrDefault();
            completedTask.TaskIsCompleted = !completedTask.TaskIsCompleted;

            if (completedTask.TaskIsCompleted == true) { 
                completedTask.CompletedDate =  DateTime.Now;
            }

            testContext.SaveChanges();
            return;
        }

        
    }
}
