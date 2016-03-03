
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

gasketThickness=1;

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


module halfSphere(internalRadius,wallsThickness,fn=64)
{
    difference()
    {
    sphere(r=internalRadius+wallsThickness,$fn=fn);
    sphere(r=internalRadius,$fn=fn);
    translate([-internalRadius-wallsThickness-padding/2,-internalRadius-wallsThickness-padding/2,-internalRadius-wallsThickness])
    cube([2*(internalRadius+wallsThickness+padding),2*(internalRadius+wallsThickness+padding),internalRadius+wallsThickness]);
    }
}

module mainBox2NoHoles()
{
difference()
{
cylinder(r=exteriorRadius, h=exteriorHeight, $fn=128);

translate([0,0,-padding/2])
cylinder(r=interiorRadius,interiorRadius, h=exteriorHeight+padding, $fn=128);
}


difference()
{
	translate([0,0,exteriorHeight-ledgeHeight])
	{
		cylinder(,r=ledgeRadius, h=ledgeHeight, $fn=128);
	}
translate([0,0,padding])
	{
	cylinder(r=interiorRadius, h=exteriorHeight, $fn=128);
	}
}

rotate([0,180,0])
halfSphere(interiorRadius,exteriorRadius-interiorRadius,fn=128);

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


module mainBoxGasketNoCentralHole()
{
    difference()
    {
        translate([0,0,exteriorHeight])
        {
            cylinder(r=ledgeRadius, h=gasketThickness, $fn=128);
        }
        translate([0,0,topCoverThickness])
        screwHoles();    
    }
}


module mainBoxGasketWithCentralHole()
{
    difference()
    {
        mainBoxGasketNoCentralHole();
        translate([0,0,exteriorHeight-padding])
        {
            cylinder(r=interiorRadius, h=exteriorHeight, $fn=128);
        }
        
    }
}


mainBoxGasketWithCentralHole();

module mainBoxWithHoles()
{
difference()
{
mainBoxNoHoles();
screwHoles();
}
}

module mainBox2WithHoles()
{
difference()
{
mainBox2NoHoles();
screwHoles();
}
}



/*rotate([0,180,0])
mainBox2WithHoles();*/
//halfSphere(30,2);

 //mainBoxWithHoles();

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


