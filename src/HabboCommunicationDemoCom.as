package
{
   import com.sulake.habbo.communication.demo.HabboCommunicationDemo;
   import mx.core.SimpleApplication;
   
   public class HabboCommunicationDemoCom extends SimpleApplication
   {
      
      public static var HabboCommunicationDemo:Class = HabboCommunicationDemo;
      
      public static var login_window:Class = HabboCommunicationDemoCom_login_window;
      
      public static var hotel_view_window:Class = HabboCommunicationDemoCom_hotel_view_window;
      
      public static var manifest:Class = HabboCommunicationDemoCom_manifest;
       
      
      public function HabboCommunicationDemoCom()
      {
         super();
      }
   }
}
