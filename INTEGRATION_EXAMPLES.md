# DevOps Agent Integration Example

This example shows how to integrate the live project with the DevOps Agent's Remote State Manager.

## Python Integration

```python
import asyncio
from core.remote_state_manager import RemoteStateManager, setup_azure_backend_for_project

async def setup_remote_state():
    # Use the convenience function
    config, migration = await setup_azure_backend_for_project(
        project_name="remote-state-demo",
        environment="demo", 
        location="East US"
    )
    
    print(f"Backend configured: {config.storage_account_name}")
    if migration:
        print(f"Migration status: {migration.status}")

# Run the setup
asyncio.run(setup_remote_state())
```

## Manual Remote State Setup

```python
import asyncio
from core.remote_state_manager import RemoteStateManager, RemoteStateConfig

async def manual_setup():
    manager = RemoteStateManager(working_directory="/Users/shaik/Desktop/new_poc_devops_agent/live_terraform_project")
    
    # Setup Azure backend
    config = await manager.setup_azure_remote_state(
        resource_group_name="rg-terraform-state-caffad",
        storage_account_name="sttfstatecaffad",
        container_name="tfstate",
        location="East US"
    )
    
    # Migrate existing state
    if Path("terraform.tfstate").exists():
        migration = await manager.migrate_local_to_remote(
            local_state_file="terraform.tfstate",
            remote_config=config,
            backup_local=True
        )
        print(f"Migration completed: {migration.status}")

asyncio.run(manual_setup())
```

## Current Project Details

- **Project Directory**: /Users/shaik/Desktop/new_poc_devops_agent/live_terraform_project
- **Resource Group**: rg-remote-state-demo-caffad
- **Storage Account**: stremotestatecaffad
- **Backend Resource Group**: rg-terraform-state-caffad
- **Backend Storage Account**: sttfstatecaffad

## Next Steps

1. **Test basic deployment**: Run `./deploy.sh`
2. **Enable remote state**: Rename `backend.tf.example` to `terraform.tf`
3. **Migrate state**: Run `terraform init -migrate-state`
4. **Integrate with agent**: Use the Python examples above
