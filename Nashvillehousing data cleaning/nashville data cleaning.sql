
--- CLEANING NASHILLEHOUSING DATA USING SQL

use nashvillehousing;
select *from nashvillehousing_data ; 
desc nashvillehousing_data;

---------------------------------------------------------------------------------------------

--- STANDARDIZE DATE FORMATE

select`Sale Date`, convert(`Sale Date`,date) from nashvillehousing_data;

SELECT `Sale Date`, STR_TO_DATE(`Sale Date`, '%d-%m-%y') AS SaleDateAsDate
FROM nashvillehousing_data;

update nashvillehousing_data 
set `Sale Date`= STR_TO_DATE(`Sale Date`, '%d-%m-%y');

---------------------------------------------------------------------------------------

--- FINDING AND FILLING NULL VALUES IN PROPERTY ADDRESS

select * from nashvillehousing_data where `Property Address`="" order by `Parcel ID`; 

Select a.`Parcel ID`, a.`Property Address`, b.`Parcel ID`, b.`Property Address`,
COALESCE(NULLIF(a.`Property Address`, ''), NULLIF(b.`Property Address`, ''))
From nashvillehousing_data a
JOIN nashvillehousing_data b
	on a.`Parcel ID` = b.`Parcel ID`
	 AND a.UniqueID <> b.UniqueID
Where a.`Property Address`="";

UPDATE nashvillehousing_data a
JOIN nashvillehousing_data b ON a.`Parcel ID` = b.`Parcel ID` AND a.UniqueID <> b.UniqueID
SET a.`Property Address` = COALESCE(NULLIF(a.`Property Address`, ''), NULLIF(b.`Property Address`, ''))
WHERE a.`Property Address` = "";

------------------------------------------------------------------------------------------------------------------

--- BREAKING OUT PROPERTY ADDRESS INTO INDIVIDUAL COLUMNS (ADDRESS,CITY) 

select `Property Address`,substring_index(concat_ws(',',`Property Address`,`Property City`),',',1),
substring_index(concat_ws(',',`Property Address`,`Property City`),',',-1) from nashvillehousing_data;

ALTER TABLE nashvillehousing_data
Add PropertyAddress varchar(255);

update nashvillehousing_data 
set PropertyAddress = substring_index(`Propery Address`,',',1);

ALTER TABLE nashvillehousing_data
Add PropertyCity varchar(255);

update nashvillehousing_data 
set PropertyAddress = substring_index(`Propery Address`,',',-1);

-----------------------------------------------------------------------------------------------------------------------

--- UPDATING EMPTY VALUES TO NULL VALUES

update nashvillehousing_data set Address=Null where Address="";
update nashvillehousing_data set City=Null where City="";

--------------------------------------------------------------------------------------------------------------------------

--- REPLACING Y TO YES AND N TO NO IN SOLDASVACANT FIELD

select distinct `sold as vacant` from nashvillehousing_data;

update nashvillehousing_data 
set `Sold As Vacant` = Case
 when `Sold As Vacant`= 'Y' then 'Yes'
 when `Sold As Vacant`='N' then 'No'
	   ELSE   SoldAsVacant
	   END;

----------------------------------------------------------------------------------------------------------------------

--- FINDING DUPLICATE VALUES

Select *,
	ROW_NUMBER() OVER (
	PARTITION BY `Parcel ID`,
				 `Property Address`,
				 `Sale Price`,
				 `Sale Date`,
				 `Legal Reference`) row_val
from nashvillehousing_data
				 ORDER BY
					UniqueID;

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY `Parcel ID`,
				 `Property Address`,
				 `Sale Price`,
				 `Sale Date`,
				 `Legal Reference`
				 ORDER BY
					UniqueID
					) row_num

From nashvillehousing_data
-- order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by UniqueID;



