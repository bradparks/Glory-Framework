﻿package ca.confidant.glory.model;    import org.puremvc.haxe.patterns.proxy.Proxy;    import ca.confidant.glory.ApplicationFacade;	import haxe.xml.Fast;	class PagesConfigProxy extends Proxy	{		public static inline var NAME:String = "pagesConfigProxy";		private var _pagesXML:Xml;		private var fast:haxe.xml.Fast;		private var allPages:Array<Hash<Dynamic>>;		private var imageItems:Array<Dynamic>;		private var randomPicks:Array<Dynamic>;		private var positions:Array<Hash<Dynamic>>;		private var randomPositions:Array<Dynamic>;		private var chosenpages:Array<Dynamic>;		private var chosenLayout:String;		private var currentPage:Int;		/**		 * Constructor.		 */		public function new ()		{			super ( NAME );			//trace("I am Pages Config Proxy!!!!");		}		public function loadXML(rawXML:String){			 randomPicks=new Array();			 positions=new Array();			randomPositions=new Array();			currentPage=0;//arrays start at zero			_pagesXML=Xml.parse(rawXML);			fast = new haxe.xml.Fast(_pagesXML.firstElement());			parseXML();		}		public function getCurrentPage():Hash<Dynamic>{			return allPages[currentPage];		}		public function setCurrentPageById(id:String):Void{			for(i in 0...allPages.length){				if(allPages[i].get("id")==id){					currentPage=i;				}			}		}		public function getPageById(id:String):Hash<Dynamic>{			for(i in 0...allPages.length){				if(allPages[i].get("id")==id){					return allPages[i];				}							}			return null;		}		public function getNextPage():Hash<Dynamic>{						var j:Int=1;						while((currentPage+j)<allPages.length){				//check if normal page				if(allPages[currentPage+j].get("type")=="normal") {					trace("normal");					return allPages[currentPage+j];				} else {					trace("notnormal");					j++;				}							} 						return null;								}		public function getPreviousPage():Hash<Dynamic>{						var j:Int=1;						while((currentPage-j)>=0){				//check if normal page				if(allPages[currentPage-j].get("type")=="normal") {					trace("normal");					return allPages[currentPage-j];				} else {					trace("notnormal");					j++;				}							} 						return null;					}		public function getBackground(pageId:String):String{			var p=getPage(pageId);			if(p!=null){				return p.get("background");			}			return("");		}		public function getPageActors(pageId:String):List<Fast>{			var p=getPage(pageId);			if ((p!=null)&&(p.get("actors")!=null)){				trace("returning actors!");				return p.get("actors");			} else {				//iOS currently returning empty, why?				trace("returning empty!");				return new List<Fast>();			}		}		public function getAppControls():List<Fast>{			trace("getAppControls");			if (fast.node.controls.hasNode.button){				return fast.node.controls.nodes.button;			}			return new List<Fast>();		}		public function getControlHref(controlId:String):String{			if (fast.node.controls.hasNode.button){				for(node in fast.node.controls.nodes.button){					//trace("getControlHref:"+node.att.id);					if(node.att.id==controlId){						return node.att.href;					}				}			}			return "#";		}		public function getActorHref(controlId:String):String{			if (fast.node.page.hasNode.actor){				for(node in fast.node.page.nodes.actor){					//trace("getControlHref:"+node.att.id);					if(node.att.id==controlId){						return node.att.href;					}				}			}			return "#";		}		private function getPage(pageId:String):Hash<Dynamic>{			for(thispage in allPages){				if(thispage.get("id")==pageId){					return thispage;				}			}			return null;		}		public function getPosition(i:Int){//Object			return randomPositions[i];		}		public function numpages():Int{			return allPages.length;		}		private function parseXML():Void{			allPages=new Array();			//feedItems=new Array();			imageItems=new Array();			//for each (var thispage:XML in _pagesXML..page){			//trace("parseXML");			for(thispage in fast.nodes.page){				var h:Hash<Dynamic> = new Hash();				if(thispage.has.id) h.set("id",thispage.att.id);				//if(thispage.has.y) h.set("y",thispage.att.y);				//if(thispage.has.x) h.set("x",thispage.att.x);				if(thispage.has.src) h.set("src",thispage.att.src);				if(thispage.has.type) h.set("type",thispage.att.type);				if(thispage.hasNode.background) h.set("background",thispage.node.background.att.src);				if(thispage.hasNode.actor) {					//trace("actors:"+thispage.nodes.actor);					//trace(Type.typeof(thispage.nodes.actor));					h.set("actors",thispage.nodes.actor);				}				//loadItems.push({name:thispage.@name,y:thispage.@y,x:thispage.@x,height:thispage.@height,width:thispage.@width,src:thispage.@src,group:thispage.@group,force:thispage.@force,config:thispage.config[0]});				allPages.push(h);				//trace(thispage.att.name);			}			sendNotification(ApplicationFacade.PAGES_CONFIG_READY);		}		public function getConfigXML(i:Int){//xml			return randomPicks[i].config;			//return loadItems[i].config;		}		public function pagesXML()//:XML		{			return _pagesXML;		}	}