package com.sulake.habbo.communication.messages.incoming.catalog
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.communication.messages.MessageEvent;
   import com.sulake.habbo.communication.messages.parser.catalog.CatalogIndexMessageParser;
   
   public class CatalogIndexMessageEvent extends MessageEvent implements IMessageEvent
   {
       
      
      public function CatalogIndexMessageEvent(param1:Function)
      {
         super(param1,CatalogIndexMessageParser);
      }
      
      public function get root() : NodeData
      {
         return (var_21 as CatalogIndexMessageParser).root;
      }
      
      public function getParser() : CatalogIndexMessageParser
      {
         return this.var_21 as CatalogIndexMessageParser;
      }
   }
}
