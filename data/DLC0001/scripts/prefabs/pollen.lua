local texture = "fx/snow.tex"
local shader = "shaders/particle.ksh"
local colour_envelope_name = "pollencolourenvelope"
local scale_envelope_name = "pollenscaleenvelope"

local assets =
{
	Asset( "IMAGE", texture ),
	Asset( "SHADER", shader ),
}

local function IntColour( r, g, b, a )
	return { r / 255.0, g / 255.0, b / 255.0, a / 255.0 }
end

local init = false
local function InitEnvelope()
	if EnvelopeManager and not init then
		init = true
		EnvelopeManager:AddColourEnvelope(
			colour_envelope_name,
			{	{ 0,	IntColour( 255, 255, 0, 50 ) },
				{ 1,	IntColour( 255, 255, 0, 200 ) },
			} )

		local max_scale = 1.
		EnvelopeManager:AddVector2Envelope(
			scale_envelope_name,
			{
				{ 0,	{ 1., max_scale } },
				{ 1,	{ 1.2, max_scale } },
			} )
	end
end

local max_lifetime = 60
local min_lifetime = 30

local function fn(Sim)
	local inst = CreateEntity()
	local trans = inst.entity:AddTransform()
	local emitter = inst.entity:AddParticleEmitter()
	inst:AddTag("FX")

	InitEnvelope()

	emitter:SetRenderResources( texture, shader )
	emitter:SetMaxNumParticles( 1000 )
	emitter:SetMaxLifetime( max_lifetime )
	emitter:SetColourEnvelope( colour_envelope_name )
	emitter:SetScaleEnvelope( scale_envelope_name );
	emitter:SetBlendMode( BLENDMODE.Premultiplied )
	emitter:SetSortOrder( 3 )
	emitter:SetAcceleration( 0, -0.01, 1 )
	emitter:SetDragCoefficient( 0.9 )
	emitter:EnableDepthTest( true )

	-----------------------------------------------------
	local rng = math.random
	local tick_time = TheSim:GetTickTime()

	local desired_particles_per_second = 0--300
	inst.particles_per_tick = desired_particles_per_second * tick_time

	local emitter = inst.ParticleEmitter

	inst.num_particles_to_emit = inst.particles_per_tick

	local bx, by, bz = 0, 0.5, 0
	local emitter_shape = CreateBoxEmitter( bx, by, bz, bx + 40, by, bz + 40 )

	local emit_fn = function()
		local vx = 0
		local vy = 0
		local vz = 0
		
		local lifetime = min_lifetime + ( max_lifetime - min_lifetime ) * UnitRand()
		local px, py, pz = emitter_shape()
		

		emitter:AddParticle(
			lifetime,			-- lifetime
			px, py, pz,			-- position
			vx, vy, vz			-- velocity
		)
	end

	local updateFunc = function()
		while inst.num_particles_to_emit > 1 do
			emit_fn( emitter )
			inst.num_particles_to_emit = inst.num_particles_to_emit - 1
		end

		inst.num_particles_to_emit = inst.num_particles_to_emit + inst.particles_per_tick
	end

	EmitterManager:AddEmitter( inst, nil, updateFunc )

    return inst
end

return Prefab( "common/fx/pollen", fn, assets) 
 
