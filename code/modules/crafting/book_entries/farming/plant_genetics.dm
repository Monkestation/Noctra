/datum/book_entry/plant_genetics
	name = "Plant Breeding and Genetics"
	category = "Agriculture"

/datum/book_entry/plant_genetics/inner_book_html(mob/user)
	return {"
		<div style="text-align: left;">
			<h2>Understanding Plant Genetics</h2>
			Every plant carries genetic traits that determine its characteristics. Through selective breeding and proper care, farmers can develop superior varieties with improved performance.<br>
			<br>

			<h2>Genetic Traits</h2>
			Plants have six primary genetic traits, each rated from 10-100:<br>
			<b>Yield:</b> Determines harvest quantity. Higher values mean more produce per plant. Every 5 points above average grants +1 extra produce.<br>
			<b>Disease Resistance:</b> Natural immunity to pests and environmental stress. Affects weed damage resistance.<br>
			<b>Quality:</b> Maximum crop quality potential. Influences the nutritional value and market worth of harvests.<br>
			<b>Growth Speed:</b> How quickly plants reach maturity. Faster growth allows more harvests per season.<br>
			<b>Water Efficiency:</b> How effectively plants use available water. Efficient varieties consume up to 40% less water and nutrients.<br>
			<b>Cold Resistance:</b> Tolerance to harsh conditions and environmental stress. Reduces damage from adverse conditions.<br>
			<br>

			<h2>Trait Quality Ratings</h2>
			<b>80-100:</b> Exceptional - Significant bonuses to plant performance<br>
			<b>60-79:</b> Good - Above average performance with noticeable benefits<br>
			<b>40-59:</b> Average - Standard performance baseline<br>
			<b>20-39:</b> Poor - Below average performance with penalties<br>
			<b>10-19:</b> Terrible - Severe performance penalties<br>
			<br>

			<h2>Improving Genetics</h2>
			Plants naturally improve through excellent care:<br>
			1. Provide optimal growing conditions (tilled soil, adequate water/nutrients)<br>
			2. Achieve high crop quality ratings (Bronze, Silver, Gold, Diamond)<br>
			3. Use blessed soil or pollination when available<br>
			4. High-yield genetics plants may produce bonus seeds with improved traits<br>
			5. Each generation can potentially improve upon the last<br>
			<br>

			<h2>Genetic Effects on Growth</h2>
			Genetics directly impact plant performance:<br>
			- Water Efficiency reduces nutrient and water consumption<br>
			- Cold Resistance reduces environmental damage<br>
			- Quality trait affects maximum achievable crop quality<br>
			- Yield trait increases harvest amounts and seed production chances<br>
			<br>

			<h2>Breeding Strategy</h2>
			- Start with the best available seed stock<br>
			- Provide excellent growing conditions to encourage natural improvement<br>
			- Aim for high crop quality to maximize genetic improvement chances<br>
			- Save seeds from your best harvests for replanting<br>
			- Be patient - genetic improvements accumulate over multiple generations<br>
			- High-quality plants with good genetics may drop bonus seeds naturally
		</div>
	"}
