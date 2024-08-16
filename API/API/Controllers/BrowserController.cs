using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Diagnostics;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BrowserController : ControllerBase
    {
        private static List<Process> browserProcesses = new List<Process>();

        [HttpPost("open-all")]
        public IActionResult OpenAllBrowsers([FromQuery] string url = "http://www.google.com")
        {
            try
            {
                var browsers = new List<string> { "chrome", "chrome", "chrome" }; // Danh sách trình duyệt

                foreach (var browser in browsers)
                {
                    var process = new Process
                    {
                        StartInfo = new ProcessStartInfo
                        {
                            FileName = browser,
                            Arguments = url,
                            UseShellExecute = true
                        }
                    };
                    process.Start();
                    browserProcesses.Add(process);
                }

                return Ok("Tất cả trình duyệt đã được mở.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi: {ex.Message}");
            }
        }

        [HttpPost("close")]
        public IActionResult CloseAllBrowsers()
        {
            try
            {
                foreach (var process in browserProcesses)
                {
                    if (!process.HasExited)
                    {
                        process.Kill();
                    }
                }
                browserProcesses.Clear();

                return Ok("Tất cả trình duyệt đã được đóng.");
            }
            catch (Exception ex)
            {
                return StatusCode(500, $"Lỗi: {ex.Message}");
            }
        }
    }
}
