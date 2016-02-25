
padding=0.1;
wallsThickness=2;


interiorRadius=10+padding;
interiorHeight=10;

exteriorRadius=interiorRadius+2*wallsThickness;
exteriorHeight=interiorHeight+wallsThickness-padding;

ledgeThickness=3;
ledgeHeight=exteriorHeight/4;

ledgeRadius=exteriorRadius+ledgeThickness*2;

topCoverThickness=2;

screwHolesRadius=3.1/2;
nbScrewHoles=6;
screwHolesDistFromEdge=ledgeThickness;

module screwHoles()
{
for ( i = [0 : nbScrewHoles-1] )
{
    rotate( i * 360 / 6, [0, 0, 1])
		{
			translate([-ledgeRadius+screwHolesDistFromEdge,0,exteriorHeight-2*ledgeThickness])
			{
   			cylinder(r=screwHolesRadius, h=2*ledgeThickness+padding, $fn=32);
			}
		}
}
}


module mainBoxNoHoles()
{
difference()
{
cylinder(r=exteriorRadius, h=exteriorHeight, $fn=128);

translate([00,0,wallsThickness])
cylinder(r=interiorRadius,interiorRadius, h=interiorHeight, $fn=128);
}


difference()
{
	translate([0,0,exteriorHeight-ledgeHeight])
	{
		cylinder(r1=exteriorRadius,r2=ledgeRadius, h=ledgeHeight, $fn=128);
	}
translate([0,0,padding])
	{
	cylinder(r=interiorRadius, h=exteriorHeight, $fn=128);
	}
}

}


module mainBoxLidNoHoles()
{
translate([0,0,exteriorHeight])
{
	cylinder(r=ledgeRadius, h=topCoverThickness, $fn=128);
}
}

module mainBoxLidWithHoles()
{

    difference()
    {
        
	mainBoxLidNoHoles();
        
    translate([0,0,topCoverThickness])
        screwHoles();    
    }

}


module mainBoxWithHoles()
{
difference()
{
mainBoxNoHoles();
screwHoles();
}
}

module mainBoxWithHoles()
{
difference()
{
mainBoxNoHoles();
screwHoles();
}
}




 mainBoxWithHoles();

//mainBoxLidWithHoles();

/*
difference()
{
cube([exteriorX,exteriorY,exteriorZ]);
translate([wallsThickness,wallsThickness,wallsThickness])
{
	cube([interiorX,interiorY,interiorZ]);
}
}*/


