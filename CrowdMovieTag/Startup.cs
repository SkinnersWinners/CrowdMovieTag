using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CrowdMovieTag.Startup))]
namespace CrowdMovieTag
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
