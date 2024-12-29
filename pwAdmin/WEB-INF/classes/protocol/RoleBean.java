/*    */ package protocol;
/*    */ 
/*    */ import com.goldhuman.Common.Octets;
/*    */ 
/*    */ public class RoleBean
/*    */ {
/*    */   public User user;
/*    */   public GRoleBase base;
/*    */   public GRoleStatus status;
/*    */   public GRolePocket pocket;
/*    */   public GRoleStorehouse storehouse;
/*    */   public GRoleTask task;
/*    */ 
/*    */   public RoleBean()
/*    */   {
/* 18 */     this.user = new User();
/* 19 */     this.base = new GRoleBase();
/* 20 */     this.status = new GRoleStatus();
/* 21 */     this.pocket = new GRolePocket();
/* 22 */     this.storehouse = new GRoleStorehouse();
/* 23 */     this.task = new GRoleTask();
/*    */   }
/*    */ 
/*    */   public String getLogString()
/*    */   {
/* 28 */     String n = "";
/*    */     try { n = this.base.name.getString(); } catch (Exception e) { e.printStackTrace(); }
/* 30 */     return new String("roleid=" + this.base.id + ",name=" + n + ",level=" + this.status.level + ",exp=" + this.status.exp + ",pp=" + this.status.pp + ",money=" + this.pocket.money);
/*    */   }
/*    */ 
/*    */   public static String ClsName(int cls)
/*    */   {
/* 36 */     switch (cls) {
/*    */     case 0:
/* 38 */       return "武侠";
/*    */     case 1:
/* 39 */       return "法师";
/*    */     case 2:
/* 40 */       return "僧侣";
/*    */     case 3:
/* 41 */       return "妖精";
/*    */     case 4:
/* 42 */       return "妖兽";
/*    */     case 5:
/* 43 */       return "魅灵";
/*    */     case 6:
/* 44 */       return "羽芒";
/*    */     case 7:
/* 45 */       return "羽灵";
/* 46 */     }return "未知";
/*    */   }
/*    */ 
/*    */   public static String GenderName(byte gender)
/*    */   {
/* 52 */     return gender > 0 ? "女" : "男";
/*    */   }
/*    */ 
/*    */   public static String StatusName(int status)
/*    */   {
/* 57 */     if (1 == status)
/* 58 */       return "正常";
/* 59 */     if (2 == status)
/* 60 */       return "必须删除";
/* 61 */     if (3 == status) {
/* 62 */       return "准备删除";
/*    */     }
/* 64 */     return "未知";
/*    */   }
/*    */ }

/* Location:           D:\download\
 * Qualified Name:     protocol.RoleBean
 * JD-Core Version:    0.6.0
 */