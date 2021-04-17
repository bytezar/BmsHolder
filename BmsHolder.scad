bmsLength=51;
bmsWidth=70;

lengthOffset=4;
widthOffset=2;

baseLength=bmsLength+2*lengthOffset;//64
baseWidth=bmsWidth+widthOffset;
baseHeight=4;

leftTopScrewOffsetX=9.5+lengthOffset;
rightTopScrewOffsetX=10+lengthOffset;
leftBottomScrewOffsetX=4+lengthOffset;
rightBottomScrewOffsetX=3.5+lengthOffset;

topScrewsOffsetY=3;
bottomScrewsOffsetY=6;

innerSpaceX=48;
batteryOffset=20.2;
batteryHolderWidth=6;

bottomHolderWidth=12;
topHolderWidth=10;
sideHolderWidth=(baseLength-innerSpaceX)/2+batteryHolderWidth;


module nutHoles()
{
	x1=baseLength-leftTopScrewOffsetX;
	x2=rightTopScrewOffsetX;
	x3=baseLength-leftBottomScrewOffsetX;
	x4=rightBottomScrewOffsetX;
	
	y1=baseWidth-widthOffset-topScrewsOffsetY;
	y2=bottomScrewsOffsetY;
	
	for(t=[[x1,y1],[x2,y1],[x3,y2],[x4,y2]])
	{
		translate([t[0],t[1],baseHeight-2])
		cylinder(h=baseHeight,d=6,$fn=6);
		
		translate([t[0],t[1],-1])
		cylinder(h=baseHeight+2,d=3,$fn=16);
	}
}

module holders()
{
	x1=(baseLength-innerSpaceX)/2;
	x2=(baseLength+innerSpaceX)/2-batteryHolderWidth;
	for(t=[x1,x2])
	{
		boHalf=batteryOffset/2;
		w=2*batteryOffset;
		union()
		{
			translate([t,baseWidth-batteryOffset/2-w,baseHeight])
			
			difference()
			{
				cube([batteryHolderWidth,w,batteryOffset/2-3]);
				
				for(q=[0,1,2])
				{
					translate([-1,q*batteryOffset,boHalf])
					rotate([0,90,0])
					cylinder(h=batteryHolderWidth+2,d=19.4,$fn=64);
				}
				
				for(q=[1,3])
				{
					translate([-1,q*boHalf,2.5])
					rotate([0,90,0])
					cylinder(h=batteryHolderWidth+2,d=3,$fn=64);
				}
			}
		}
	}
}

union()
{
	difference()
	{
		cube([baseLength,baseWidth,baseHeight]);
		
		translate([sideHolderWidth,bottomHolderWidth,-1])
		cube([baseLength-2*sideHolderWidth,baseWidth-bottomHolderWidth-topHolderWidth,baseHeight+2]);
		
		nutHoles();
	}
	
	holders();
}