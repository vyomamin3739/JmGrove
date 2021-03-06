USE [BSNL]
GO
/****** Object:  Table [dbo].[DesigM]    Script Date: 10/16/2017 5:57:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DesigM](
	[DesigId] [int] NOT NULL,
	[DesigNm] [nvarchar](50) NULL,
	[DesigTypeID] [int] NULL,
 CONSTRAINT [PK_DesigM] PRIMARY KEY CLUSTERED 
(
	[DesigId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[tbl_Designation]    Script Date: 10/16/2017 5:57:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Designation](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DesignationType] [nvarchar](50) NULL,
	[DesignationCode] [nvarchar](10) NULL,
 CONSTRAINT [PK_tbl_Designation] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  StoredProcedure [dbo].[DesigCode]    Script Date: 10/16/2017 5:57:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DesigCode] 
	-- Add the parameters for the stored procedure here
	 @Id int=0,
     @DesignationType varchar(50)=null,
	 @DesignationCode varchar(10)=null,
     @QryType char(1)=null
     
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if @QryType='S'
		Begin
               select * from tbl_Designation order by id desc
        End
	if @QryType='G'
        Begin
               select id from tbl_Designation WHERE DesignationCode = @DesignationCode
         End
END

GO
/****** Object:  StoredProcedure [dbo].[DesigProc]    Script Date: 10/16/2017 5:57:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[DesigProc]
  @DesigId int=0,
  @DesigNm varchar(50)=null,
  @QryType char(1)=null,
  @DesigTypeID int = 0
As
  Begin
      if @QryType='I'
            Begin
               insert into DesigM values (@DesigId,@DesigNm,@DesigTypeID)
            End  
       if @QryType='U'
            Begin
               update DesigM set DesigNm=@DesigNm,DesigTypeID=@DesigTypeID where DesigId=@DesigId
            End
       if @QryType='D'
            Begin
               delete from DesigM where DesigId=@DesigId
            End 
       if @QryType='S'
            Begin
               select DM.DesigId ,DM.DesigNm , DM.DesigTypeID, TD.DesignationCode from DesigM DM INNER JOIN tbl_Designation TD ON TD.id = DM.DesigTypeID order by DesigId desc
            End
		if @QryType='E'
            Begin
               select DesigNm,DesigTypeID from DesigM where DesigId=@DesigId
            End
        if @QryType='M'
            Begin
	  declare @mid int
	select @mid=max(DesigId) from DesigM
	if(@mid is null)
	 set @mid=1
	else
	 set @mid=@mid + 1
		 return @mid
            End  
End




GO
